class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.4",
      revision: "3772aa0a5f80c486df0761da04343f7d496899c5"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "6abbe821959e1568ff0d971029b547d3a674f7e6897729ba181dcac30fec5a01"
    sha256 cellar: :any_skip_relocation, ventura:      "f2a71bd327677341f1a7fddb8346fe18b2870e1075d05f59b6e16c710fac7c3d"
  end

  depends_on "gradle" => :build
  depends_on xcode: ["14.1", :build]
  depends_on :macos

  def install
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "gradle", "--no-daemon", "linkDebugExecutableMacos#{suffix}"
    bin.install "cli-build/build/bin/macos#{suffix}/debugExecutable/cli-build.kexe" => "gitportal"
  end

  test do
    output = shell_output(bin/"gitportal --help")
    assert_match "Usage: gitportal options_list", output
  end
end

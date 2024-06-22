class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.16",
      revision: "7da63d33cc0e1c74db7716b24254b89a3e17ad00"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.14"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "cc7d90e63fb3577019e1ad24ad0a0674b61d3d23b571f15b32a637e02f7b40f7"
    sha256 cellar: :any_skip_relocation, ventura:      "c1a61b5634a4ef60f5fdee109a47e79bd6233d201f48f0c4d874bfc329aef02d"
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

class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.6.66",
      revision: "8798286bded8d74296787a297f076aad323f9668"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.64"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "9772b4c10b928b1856c7f8cb4cc47c3d38a2d0c9cf1ad7cbde112d1b76f77236"
    sha256 cellar: :any_skip_relocation, ventura:      "b0cefe3ed6cd02997096c2ba012527212cde691d64a1bb8193ff1c48e16329da"
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

class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.14",
      revision: "78336a43ad9530d671b4118cbb78d422e70b8fe7"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.12"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a31d2d28167d59cf611d4efeae1dc2907b7de797584d1da87e4a934d39b8aa76"
    sha256 cellar: :any_skip_relocation, ventura:      "f8f71c71fa02e14f77b873878b6c6dd47254d680f3652e2c7a02558d91792b47"
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

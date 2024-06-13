class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.6.56",
      revision: "367cced31ee056d8198fbeba69df3db0b122fe6b"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.55"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "a925749c9dfe0c26179250f2b24f0565ba4d5e6de0eb8b9aff577a87ce3ef93b"
    sha256 cellar: :any_skip_relocation, ventura:      "45b6f81e0ebacdf447b0b20485ac963efeede0e8e283eca016278508f48a9abc"
  end

  depends_on "gradle" => :build
  depends_on xcode: ["14.1", :build]
  depends_on :macos

  def install
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "gradle", "--no-daemon", "linkReleaseExecutableMacos#{suffix}"
    bin.install "cli-build/build/bin/macos#{suffix}/releaseExecutable/cli-build.kexe" => "gitportal"
  end

  test do
    output = shell_output(bin/"gitportal --help")
    assert_match "Usage: gitportal options_list", output
  end
end

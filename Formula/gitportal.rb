class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.6.46",
      revision: "5d4afd950915c99d82b73a193c65efbee305e28c"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.46"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "59a7b29b4d1699f1eaf65469213c976e62c50cdea48f672c570bd58865e8b8b6"
    sha256 cellar: :any_skip_relocation, ventura:      "119cb1dbc02c81e978c48248fe0b28c6d8e753ea8c1322ab8eef6342090423fe"
  end

  depends_on "gradle" => :build
  depends_on xcode: ["14.1", :build]
  depends_on :macos

  def install
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "gradle", "--no-daemon", "-Pbrewbuild=true", "linkReleaseExecutableMacos#{suffix}"
    bin.install "cli-build/build/bin/macos#{suffix}/releaseExecutable/cli-build.kexe" => "gitportal"
  end

  test do
    output = shell_output(bin/"gitportal --help")
    assert_match "Usage: gitportal options_list", output
  end
end

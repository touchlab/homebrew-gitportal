class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag: "0.6.24",
      revision: "5f3490cc5c39213be541c9db0ed6f1b72fcc0386"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.23"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b6558f6202fb8ef8daecba742e6b7a0f7f7a5d4b9ce44bfe40400362f521cee6"
    sha256 cellar: :any_skip_relocation, ventura:      "48a563b137901b0f71f13dc88272afcc02c787cbfd29909a654f3608989209d0"
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

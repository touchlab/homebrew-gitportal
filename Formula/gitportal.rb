class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.6.35",
      revision: "ccff48875fd95ac2b246645865ac3a60fd84f705"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.30"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "56040386c8e0ca61e56cc49b27d90bbdd8a212bebf3cdeabb1d0e01630016ceb"
    sha256 cellar: :any_skip_relocation, ventura:      "33546165f21cd8a02f43462c2d24535b13ec6042ec3aba9c78543e56cd7c0dc4"
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

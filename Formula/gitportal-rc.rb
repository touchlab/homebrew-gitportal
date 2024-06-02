class GitportalRc < Formula
  desc "GitPortal CLI Tool - Release Candidate"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag: "0.6.0",
      revision: "e236115c809788dc7de2e791624bf8985f18f363"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  depends_on "gradle" => :build
  depends_on xcode: ["14.1", :build]
  depends_on :macos

  def install
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "gradle", "--no-daemon", "linkReleaseExecutableMacos#{suffix}"
    bin.install "cli-build/build/bin/macos#{suffix}/releaseExecutable/cli-build.kexe" => "gitportal-rc"
  end

  test do
    output = shell_output(bin/"gitportal-rc --help")
    assert_match "Usage: gitportal options_list", output
  end
end

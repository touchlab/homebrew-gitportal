class GitportalRc < Formula
  desc "GitPortal CLI Tool - Release Candidate"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag: "0.6.13",
      revision: "51943e2baf00fe7aaf8ba847f4ec5a517a49b606"
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

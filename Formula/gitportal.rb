class Gitportal < Formula
  desc "GitPortal CLI Tool"
  homepage "https://github.com/touchlab/GitPortal"
  url "https://github.com/touchlab/GitPortal.git",
      tag: "0.5.19",
      revision: "a048021b2bbff44bc293925cfb72f6814f997398"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortal.git", branch: "main"

  depends_on "gradle" => :build
  depends_on xcode: ["14.1", :build]
  depends_on :macos

  def install
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "gradle", "--no-daemon", "linkReleaseExecutableMacos#{suffix}"
    bin.install "cli/build/bin/macos#{suffix}/releaseExecutable/cli.kexe" => "gitportal"
  end

  test do
    output = shell_output(bin/"gitportal --help")
    assert_match "Usage: gitportal options_list", output
  end
end

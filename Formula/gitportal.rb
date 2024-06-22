class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.18",
      revision: "fe794ad4b7f3008d1e37a5020eaa80969be58570"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.18"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "cdfdfb518a4eabcc311dba63f6e83f88b7880e6307c5e224b5e2c0f2873a9893"
    sha256 cellar: :any_skip_relocation, ventura:      "d7c8a8efba021f7847aa737a2d0e67cc5b003aa9faad1f5ba8c20594695ef4c2"
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

class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.22",
      revision: "9bddbd7ed42bfc66b504e27cb723871b94e9189e"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.20"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "77b8ba8cd83c4203c2042e7eebd54520bad307f3bf2e18f43e3980641c0caa8d"
    sha256 cellar: :any_skip_relocation, ventura:      "116d9273e04029237040c83b5ea92f61709071b5d72c2f017735dfb6f4c1b188"
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

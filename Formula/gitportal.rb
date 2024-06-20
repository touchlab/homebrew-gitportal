class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.12",
      revision: "1ca119f155d7702da3a5ec7e2e8b04424fb333e8"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.10"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "488fc97fe85048e9c7ee1a6728c1a05218698aa755fbf7893f24760132f55d5c"
    sha256 cellar: :any_skip_relocation, ventura:      "64bc5b37b9b97e44d18cb9778175c992ee67e212334e59eaf0f6c6783ea27e85"
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

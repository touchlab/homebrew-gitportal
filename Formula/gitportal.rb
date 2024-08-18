class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.24",
      revision: "a7a6171f48903eaf12191ffee6e6b0feb62e6427"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.24"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8427a4e0c095c081eb2851256c211a2b4181afa88377b0b2949731898755269a"
    sha256 cellar: :any_skip_relocation, ventura:      "dd48c5138d2671c1bd7da6045cc5c450a58e045108cd87af3e3920fc84b15fd2"
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

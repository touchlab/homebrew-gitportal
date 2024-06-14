class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.6.68",
      revision: "1fbf94e7eab062f2a0bf6c4037c038db416148f3"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.66"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5f9e2dec75c86a0c56e8b8aaacf9aaa8f45006dbd3226d54ae37c609667f3d88"
    sha256 cellar: :any_skip_relocation, ventura:      "b1219b5fcc42ad0385f7028b33bbe2deee935a5f5d7d919b497b84f674c48a4f"
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

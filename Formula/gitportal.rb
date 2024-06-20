class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.10",
      revision: "6e364ea921d55ba39838004cb36d571141cdc6c9"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "85c0c1c3096e4111a22632a1bb5d8879b7631459d1f35fe8f45a496309efd0da"
    sha256 cellar: :any_skip_relocation, ventura:      "cc0138d43de422a6ea16760653014adf8852bde1ec1d8979e60d654d8795067f"
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

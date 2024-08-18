class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.24",
      revision: "a7a6171f48903eaf12191ffee6e6b0feb62e6427"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.22"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "4977e05c97b3f710aae48b3605b8bc3064d9f6b74dc871502215d48a944ae175"
    sha256 cellar: :any_skip_relocation, ventura:      "74e6f3d21f417f8e427bd165d31c7a676cc0e799ef6f307a24f8938c1cef8d9b"
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

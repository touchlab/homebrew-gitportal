class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.6",
      revision: "58715e5855f25bf24447ca33a35a79a0f611c494"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.7.6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "fd2592c7b29092d6858df8238f0d30f48df0ec0963b31856d1f99aae4dea8709"
    sha256 cellar: :any_skip_relocation, ventura:      "6facfab81802166598e74517c5a42a4113092daf5efb2358bf3cc7aa7c0e711e"
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

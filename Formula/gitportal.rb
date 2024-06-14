class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.6.58",
      revision: "d88a9ddc6b789a29aaff29a5b45c4c335c146271"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.58"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "43ac648f0c63dc29a6fba321e0343a3da230bf8cb877ede2279da477c97b0276"
    sha256 cellar: :any_skip_relocation, ventura:      "fd86f1da5b0c3a8a9a3602aea1365939263345a90845698626fa64231556f725"
  end

  depends_on "gradle" => :build
  depends_on xcode: ["14.1", :build]
  depends_on :macos

  def install
    suffix = (Hardware::CPU.arch == :x86_64) ? "X64" : "Arm64"
    system "gradle", "--no-daemon", "linkReleaseExecutableMacos#{suffix}"
    bin.install "cli-build/build/bin/macos#{suffix}/releaseExecutable/cli-build.kexe" => "gitportal"
  end

  test do
    output = shell_output(bin/"gitportal --help")
    assert_match "Usage: gitportal options_list", output
  end
end

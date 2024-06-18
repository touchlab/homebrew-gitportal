class Gitportal < Formula
  desc "CLI Tool"
  homepage "https://github.com/touchlab/GitPortalCli"
  url "https://github.com/touchlab/GitPortalCli.git",
      tag:      "0.7.2",
      revision: "3066dada98a5dc8e9b2d0501243f589adb25afd3"
  license "Apache-2.0"
  head "https://github.com/touchlab/GitPortalCli.git", branch: "main"

  bottle do
    root_url "https://github.com/touchlab/homebrew-gitportal/releases/download/gitportal-0.6.68"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "46b1a93c57d872869194c012dfe089e345df7dc903510a4b03026758e565ebfb"
    sha256 cellar: :any_skip_relocation, ventura:      "feabc3645d79c1442d60de9ecf1a60613e8bb135c6145346438ca4ef2a61bebc"
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

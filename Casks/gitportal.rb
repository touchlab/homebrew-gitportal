cask "gitportal" do
  arch arm: "aarch64", intel: "x86-64"
  folder = on_arch_conditional arm: "aarch64", intel: "x86_64"

  version "0.3.4"
  sha256 arm:   "6081667bd773d223af88c9361d7cfc1f7293690acb65e5b9346ee7923810db62",
         intel: "29efd0e0dbdb22b59fa06db573b8b36a671054c6fff9ec7798a1cc2df3c1bdf2"

  url "https://doppldocs.s3.amazonaws.com/gitportal-#{version}-#{arch}",
      verified: "doppldocs.s3.amazonaws.com/"

  binary "gitportal"
end

cask "gitportal" do
  arch arm: "aarch64", intel: "x86-64"
  folder = on_arch_conditional arm: "aarch64", intel: "x86_64"

  version "0.3.4"
  sha256 arm:   "a2b1ca9325e42a8e3991d5ac3581ba656338caa075b339645b95e86484feb568",
         intel: "ec98a59ccc2306e0044d59607912899fdb2175713f027d8a39b2553ea68ab2c4"

  url "https://doppldocs.s3.amazonaws.com/gitportal-#{version}-#{arch}",
      verified: "doppldocs.s3.amazonaws.com/"

  binary "gitportal-#{version}-#{arch}", target: "gitportal"
end

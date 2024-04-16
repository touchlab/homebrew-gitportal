cask "gitportal" do
  arch arm: "aarch64", intel: "x86-64"
  folder = on_arch_conditional arm: "aarch64", intel: "x86_64"

  version "0.3.4"
  sha256 arm:   "81eab945a33622fc156951e804024d23aa9a745c06743b4947215ed9303ad1c4",
         intel: "ede541af151487f60eb518e310d20dad1a973f3dbe9ff78d782dd29b14ba2946"

  url "https://github.com/touchlab/GitPortal/releases/download/#{version}/gitportal-#{version}-#{arch}/",
      verified: "github.com/touchlab/GitPortal/releases/download/"

  binary "gitportal-#{version}-#{arch}"
end

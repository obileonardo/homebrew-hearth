cask "hearth" do
  version "0.1.10"
  sha256 "6b9e4ff935886ab43041f8a752200aaac34591c5447c7ee73a40097db4139980"

  url "https://github.com/obileonardo/hearth-macos/releases/download/v#{version}/Hearth-#{version}-universal.dmg"
  name "Hearth"
  desc "Native menu bar app for Home Assistant"
  homepage "https://github.com/obileonardo/hearth-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Hearth.app"

  uninstall quit: "com.elvisobi.hearth"

  zap trash: [
    "~/Library/Application Support/Hearth",
    "~/Library/Caches/com.elvisobi.hearth",
    "~/Library/HTTPStorages/com.elvisobi.hearth",
    "~/Library/Preferences/com.elvisobi.hearth.plist",
    "~/Library/WebKit/com.elvisobi.hearth",
  ]
end

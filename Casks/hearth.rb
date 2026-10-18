cask "hearth" do
  version "0.1.8"
  sha256 "7120c2b5821b80809db66fcf0a4a14c21d7a445c514f12fc08520b209c75d021"

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

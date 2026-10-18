#!/bin/bash
# Lint, install, verify and uninstall the Hearth cask on a clean macOS runner.
set -euo pipefail

cask="obileonardo/hearth/hearth"
app="/Applications/Hearth.app"
team="DD8UY75RZT"

brew style --cask "$cask"
brew audit --cask --strict --online "$cask"

brew install --cask "$cask"

expected=$(brew info --cask --json=v2 "$cask" | ruby -rjson -e 'puts JSON.parse($stdin.read)["casks"][0]["version"]')
installed=$(defaults read "$app/Contents/Info.plist" CFBundleShortVersionString)
[[ "$installed" == "$expected" ]] || { echo "Installed $installed, cask says $expected" >&2; exit 1; }

codesign --verify --strict --deep "$app"
codesign -dvv "$app" 2>&1 | grep -q "^Authority=Developer ID Application: .*($team)$" \
  || { echo "Not signed with Developer ID team $team" >&2; exit 1; }
# stapler validate asks Apple's ticket service online; retry dropped connections.
for attempt in 1 2 3 4; do
  xcrun stapler validate "$app" && break
  [[ $attempt -lt 4 ]] || { echo "Stapled ticket could not be validated" >&2; exit 1; }
  sleep $((attempt * 15))
done

# Hosted runners may have Gatekeeper assessments switched off; only judge the
# result when the assessment really ran.
assessment=$(spctl -a -t exec -vv "$app" 2>&1 || true)
echo "$assessment"
if ! grep -q "override=" <<<"$assessment"; then
  grep -q "source=Notarized Developer ID" <<<"$assessment" \
    || { echo "Gatekeeper did not accept the app as notarized" >&2; exit 1; }
fi

brew uninstall --cask --zap "$cask"
[[ ! -e "$app" ]] || { echo "$app still present after uninstall" >&2; exit 1; }
echo "Hearth $installed installed, verified and removed."

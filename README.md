# Homebrew tap for Hearth

[Hearth](https://github.com/obileonardo/hearth-macos) is a native macOS menu bar app for Home Assistant.

## Install

```sh
brew install --cask obileonardo/hearth/hearth
```

This installs the same Developer ID signed, Apple-notarized universal disk image published on [Hearth's releases](https://github.com/obileonardo/hearth-macos/releases), checked against its SHA-256. Requires macOS 14 or later.

## Update

```sh
brew upgrade --cask hearth
```

The cask follows Hearth's latest release automatically: a daily check updates it once the new version installs and verifies on a clean Mac.

## Uninstall

```sh
brew uninstall --cask hearth          # removes the app; keeps your settings
brew uninstall --cask --zap hearth    # also removes Hearth's settings, caches, saved activity, faces and maps
```

`--zap` does not remove the Home Assistant sign-in Hearth saved in your Keychain; delete the `com.elvisobi.hearth` item in Keychain Access if you no longer need it.

## How it is checked

Every change installs the cask on a clean GitHub macOS runner, confirms the installed version, the Developer ID signature and the stapled notarization ticket, then uninstalls it. See [`.github/scripts/check-cask.sh`](.github/scripts/check-cask.sh).

Problems with the app itself belong in [Hearth's issues](https://github.com/obileonardo/hearth-macos/issues).

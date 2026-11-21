# Template of the cask published to the tap beatsfaty/homebrew-macpurifier (Casks/macpurifier.rb).
# release-app.yml rewrites `version` and `sha256` at every release; never edit them by hand.
# 1.0.0 was set by hand: published from a local build on 2026-11-21 (release runbook, part D).
cask "macpurifier" do
  version "1.0.0"
  sha256 "54a573333fffc39c98f7bc5cb9b1eaa98c0eaf8320685d73ecee5230f51172a8"

  url "https://github.com/beatsfaty/macpurifier-releases/releases/download/v#{version}/MacPurifier-#{version}.zip"
  name "MacPurifier"
  desc "Safe Mac cleaner and app uninstaller: everything goes to the Trash, no telemetry"
  homepage "https://macpurifier.com"

  depends_on macos: :ventura

  app "MacPurifier.app"

  # Refresh LaunchServices so the Dock/Launchpad icon updates immediately on
  # (re)install instead of showing a stale cached icon.
  postflight_steps do
    run "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister",
        args: ["-f", "{{appdir}}/MacPurifier.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.macpurifier.app.plist",
    "~/Library/Caches/com.macpurifier.app",
    "~/Library/LaunchAgents/com.macpurifier.scheduler.plist",
  ]
end

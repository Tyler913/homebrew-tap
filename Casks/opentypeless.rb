cask "opentypeless" do
  arch arm: "arm64", intel: "x64"

  version "2.5.0"
  sha256 arm:   "9eeb6f981ce1be44677d9c6347bde6a19ce5cc2be41b11fdedb8f80fb465950a",
         intel: "f10ff5256b43f7edf6fdacc7db2bb47dbc07a278e8618906e96747d065bd5bc6"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/2.5.0/OpenTypeless-#{version}-macOS-#{arch}.zip"
  name "OpenTypeless"
  desc "Voice typing: hold a key, talk, and cleaned-up text is pasted at the cursor"
  homepage "https://github.com/Tyler913/OpenTypeless"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself from GitHub Releases (Settings → General → Updates).
  auto_updates true
  depends_on macos: :tahoe

  app "OpenTypeless.app"

  # Not notarized (that needs a paid Apple developer account), so macOS would refuse to open the downloaded app.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "OpenTypeless.app"],
                          chdir: "{{appdir}}", writable_paths: ["{{appdir}}/OpenTypeless.app"]
  end

  uninstall quit: "local.opentypeless.app"

  zap trash: [
    "~/Library/Application Support/OpenTypeless",
    "~/Library/Preferences/local.opentypeless.app.plist",
  ]
end

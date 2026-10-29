cask "opentypeless" do
  arch arm: "arm64", intel: "x64"

  version "2.0.0"
  sha256 arm:   "5383fd9160d981808e306ea0126c30223939117a59f4c382408c7e31f1f4e3d0",
         intel: "107179163dd1f9bd57b93058f50176157cf1c2d4a46f208c5180be9212d89c86"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/2.0.0/OpenTypeless-#{version}-macOS-#{arch}.zip"
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

cask "opentypeless" do
  arch arm: "arm64", intel: "x64"

  version "2.4.0"
  sha256 arm:   "6e55a8223979e524ff331f018eb58eedd181ab782fa84d635e81941c19737986",
         intel: "6752b31314e2e7f3ec8dcc8c6c9f6d8b51263f8331271f3a06a509ce4214ee98"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/2.4.0/OpenTypeless-#{version}-macOS-#{arch}.zip"
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

cask "opentypeless" do
  version "1.3.7"
  sha256 "a95754e4862d0e84194a0beaedcbee8c918905dc3ac1a2405184ea341a08dc10"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/1.3.7/OpenTypeless-#{version}-macOS-arm64.zip"
  name "OpenTypeless"
  desc "Voice typing: hold a key, talk, and cleaned-up text is pasted at the cursor"
  homepage "https://github.com/Tyler913/OpenTypeless"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself from GitHub Releases (Settings → General → Updates).
  auto_updates true
  depends_on arch: :arm64
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

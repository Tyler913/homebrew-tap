cask "opentypeless" do
  arch arm: "arm64", intel: "x64"

  version "1.4.3"
  sha256 arm:   "8dcb674b45e4870f6dcc04fd1f3b5f3b3b527ec549372c556a8aca2eb5cf631d",
         intel: "65fa9c6af97f38eb3eca101009c35982319e5580a7348281feac17d7057f3801"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/1.4.3/OpenTypeless-#{version}-macOS-#{arch}.zip"
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

cask "opentypeless" do
  arch arm: "arm64", intel: "x64"

  version "2.6.1"
  sha256 arm:   "58bb22c42e48b9f169be41aa99b91549e09020ee4d94d253bd51662c5fe93246",
         intel: "c38c93e1f3f193e7e039088e6fc22ba121580b0e9ff50cb0e2348654d5752ecb"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/2.6.1/OpenTypeless-#{version}-macOS-#{arch}.zip"
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

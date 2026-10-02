cask "opentypeless" do
  arch arm: "arm64", intel: "x64"

  version "1.4.1"
  sha256 arm:   "7de6ffdd97b6f80efc9e82785761cc15eab0ddeecc2144a2ee774c7dfe0dcbaf",
         intel: "21346aa5000482702529e4887f0714956685e49b516b56e10e848f594c2e2da7"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/1.4.1/OpenTypeless-#{version}-macOS-#{arch}.zip"
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

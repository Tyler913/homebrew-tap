cask "opentypeless" do
  arch arm: "arm64", intel: "x64"

  version "1.4.2"
  sha256 arm:   "389fa15d4be312d3a479d9acfe7a7e29cf88d3d9929b10b1d016e5c126e6c3df",
         intel: "bac2d770d4b1de0c292a22f95c275388c8acface9302e11b01d189a1d63f52c6"

  url "https://github.com/Tyler913/OpenTypeless/releases/download/1.4.2/OpenTypeless-#{version}-macOS-#{arch}.zip"
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

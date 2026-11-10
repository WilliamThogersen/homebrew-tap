cask "townhall" do
  version "0.2.0-alpha.1"
  sha256 "42d02713dcbdf97cd0de15963fd656e66db1437358c6cac1c963cb2119cb3710"

  url "https://github.com/WilliamThogersen/townhall/releases/download/v#{version}/Townhall-macos.zip"
  name "Townhall"
  desc "Spawn, supervise and observe many coding agents in parallel"
  homepage "https://github.com/WilliamThogersen/townhall"

  depends_on macos: :big_sur

  app "Townhall.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Townhall.app"],
                   must_succeed: false
  end

  zap trash: "~/.townhall"

  caveats <<~EOS
    Townhall is signed ad hoc, not notarized. The install removes the quarantine flag so it opens.
    If macOS still blocks it, run:
      xattr -dr com.apple.quarantine /Applications/Townhall.app
    Townhall needs git and tmux: brew install git tmux
  EOS
end

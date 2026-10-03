class Pagehub < Formula
  desc "Single-binary LAN HTML artifact hosting with a local MCP interface"
  homepage "https://github.com/kuopenx/pagehub"
  url "https://github.com/kuopenx/pagehub/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "2bcef1eb0f6480afa53c69b01af1cfab487bd8111cb7b121b623c2fead2e421d"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = "-s -w -X github.com/kuopenx/pagehub/internal/buildinfo.Version=#{version} " \
              "-X github.com/kuopenx/pagehub/internal/buildinfo.Commit=f10406e0ed04309c0afe00319873b1d449841c57"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pagehub"
    doc.install "README.md", "README.zh-CN.md", "SECURITY.md", "SECURITY.zh-CN.md", "THIRD_PARTY_NOTICES.md"
  end

  def caveats
    <<~EOS
      macOS/Linux background setup (no root):
        pagehub setup
        pagehub connect codex  # or claude
        pagehub doctor
        pagehub open

      After upgrading, run `pagehub setup` to update the managed background binary.
      Use Pagehub's service commands; do not register a second Homebrew service.
      Linux requires an active systemd user manager (systemd 240+).
      Autostart is on login; use loginctl enable-linger explicitly for boot without login.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pagehub version")
    assert_match "Commands:", shell_output("#{bin}/pagehub --help")
    assert_match "port must be", shell_output("#{bin}/pagehub serve --port 0 2>&1", 2)
  end
end

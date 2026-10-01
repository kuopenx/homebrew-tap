class Pagehub < Formula
  desc "Single-binary LAN HTML artifact hosting with a local MCP interface"
  homepage "https://github.com/kuopenx/pagehub"
  url "https://github.com/kuopenx/pagehub/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "5a761bbee100b9e5b07a4fb3394d858144f563abd98d1a8e2f115fc7bbe916d4"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = "-s -w -X github.com/kuopenx/pagehub/internal/buildinfo.Version=#{version} " \
              "-X github.com/kuopenx/pagehub/internal/buildinfo.Commit=8da9d572f5a43ceae0553c5dc8d458fe042a3dcc"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pagehub"
    doc.install "README.md", "README.zh-CN.md", "SECURITY.md", "SECURITY.zh-CN.md", "THIRD_PARTY_NOTICES.md"
  end

  def caveats
    <<~EOS
      macOS background setup (no root):
        pagehub setup
        pagehub connect codex  # or claude
        pagehub doctor
        pagehub open

      After upgrading, run `pagehub setup` to update the managed background binary.
      Use Pagehub's service commands; do not register a second Homebrew service.
      Linux supports `pagehub serve`; background management is macOS-only.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pagehub version")
    assert_match "Commands:", shell_output("#{bin}/pagehub --help")
    assert_match "port must be", shell_output("#{bin}/pagehub serve --port 0 2>&1", 2)
  end
end

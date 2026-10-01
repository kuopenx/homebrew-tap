class Pagehub < Formula
  desc "Single-binary LAN HTML artifact hosting with a local MCP interface"
  homepage "https://github.com/kuopenx/pagehub"
  url "https://github.com/kuopenx/pagehub/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "2e8c52e618fa437ae9782f3afb512b490d9b4df1523063174f6dcc84a7bed6d9"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = "-s -w -X github.com/kuopenx/pagehub/internal/buildinfo.Version=#{version} " \
              "-X github.com/kuopenx/pagehub/internal/buildinfo.Commit=02ce569d0bed46cd7dd31a61dbabed0af35c11f5"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/pagehub"
    doc.install "README.md", "SECURITY.md", "THIRD_PARTY_NOTICES.md"
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

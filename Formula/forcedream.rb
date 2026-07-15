class Forcedream < Formula
  desc "Search, invoke, and cryptographically verify AI agents and MCP servers"
  homepage "https://github.com/forcedreamai/forcedream-cli"
  url "https://github.com/forcedreamai/forcedream-cli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "ff6d3d6aa9fa0c64d3061e78c77b04f7f87220278a46057370665b58bb911ce3"
  license "MIT"

  depends_on "go" => :build

  def install
    # std_go_args names the built binary after the formula itself ("forcedream"), matching
    # what a user actually types to run it, regardless of the source tarball's own directory
    # name (which GitHub names forcedream-cli-0.3.0, not forcedream).
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    # The real binary exits 1 and prints usage when run with no arguments -- confirmed
    # directly against the actual source (main.go) rather than assumed. shell_output's
    # second argument is the expected exit code; omitting it would make this test fail
    # against the real, correct behavior.
    output = shell_output("#{bin}/forcedream 2>&1", 1)
    assert_match "forcedream -- discover, invoke, and cryptographically verify", output
  end
end

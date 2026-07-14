class Forcedream < Formula
  desc "Search, invoke, and cryptographically verify AI agents and MCP servers"
  homepage "https://github.com/forcedreamai/forcedream-cli"
  url "https://github.com/forcedreamai/forcedream-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "5c4249c9339053bc1a38f69137954fe96e68dedd5f8a7a8ecb978adc09681cc7"
  license "MIT"

  depends_on "go" => :build

  def install
    # std_go_args names the built binary after the formula itself ("forcedream"), matching
    # what a user actually types to run it, regardless of the source tarball's own directory
    # name (which GitHub names forcedream-cli-0.2.0, not forcedream).
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

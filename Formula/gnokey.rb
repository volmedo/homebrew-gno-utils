class Gnokey < Formula
  desc "gnokey is a tool for managing https://gno.land accounts and interact with instances."
  homepage "https://gno.land/"
  url "https://github.com/gnolang/gno/archive/refs/tags/chain/test3.2.tar.gz"
  sha256 "0c9deeb4171d2c2c4fe281ae1d02caef8ba66c72868647e57aa2f70e2236a5ce"
  license "gno-1.0"

  depends_on "go" => :build

  def install
    # std_go_args includes -trimpath, which removes references to the local file system in the resulting binary,
    # essentially making package paths relative, which breaks amino 
    # TODO: Check why amino requires absolute file paths
    system "go", "build", "-o", bin/name, "-ldflags=-s -w", "./cmd/gnokey"
    prefix.install "README.md" 
    prefix.install "LICENSE.md" 
  end

  test do
    # check gnokey works by using generate, which should output a passphrase of 24 random words
    assert_match /^(\w+\s){23}\w+$/, shell_output("#{bin}/gnokey generate")
  end
end

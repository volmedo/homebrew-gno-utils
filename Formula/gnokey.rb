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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gnokey`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

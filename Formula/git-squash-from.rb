class GitSquashFrom < Formula
    desc "Interactive CLI to squash commits into a selected base commit"
    homepage "https://github.com/hanif-mianjee/homebrew-git-squash-from"
    url "https://github.com/hanif-mianjee/git-squash-from/archive/refs/tags/v0.1.1.tar.gz"
    sha256 "c7103f6defa20046cda9126c2d3ec3cd42325223eb9a0f510342b53fa3703ced"  # Run `shasum -a 256 <tarball>` after release
    license "MIT"
  
    def install
      bin.install "bin/git-squash-from"
    end
  end
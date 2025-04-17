class GitSquashFrom < Formula
    desc "Interactive CLI to squash commits into a selected base commit"
    homepage "https://github.com/hanif-mianjee/git-squash-from"
    url "https://github.com/hanif-mianjee/git-squash-from/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "41087e563ae7870ae4aa9ba0ba1590a9bbe98ebce55fc7d9fcbbece5a94d8d5b"  # Run `shasum -a 256 <tarball>` after release
    license "MIT"
  
    def install
      bin.install "bin/git-squash-from"
    end
  end
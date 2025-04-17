class GitSquashFrom < Formula
    desc "Interactive CLI to squash commits into a selected base commit"
    homepage "https://github.com/hanif-mianjee/homebrew-git-squash-from"
    url "https://github.com/hanif-mianjee/homebrew-git-squash-from/archive/refs/tags/v0.1.1.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"  # Run `shasum -a 256 <tarball>` after release
    license "MIT"
  
    def install
      bin.install "bin/git-squash-from"
    end
  end
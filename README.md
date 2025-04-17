## Publishing a New Version

To publish a new version, follow these steps:

1. Push your changes to the repository.
2. Create a new tag for the version.
3. Update the Homebrew Formula using a command like the following:

   ```bash
   curl -Ls https://github.com/hanif-mianjee/git-squash-from/archive/refs/tags/v0.1.1.tar.gz | shasum -a 256
   ```

## Installation

To install the tool using Homebrew, run the following commands:

```bash
brew untap hanif-mianjee/homebrew-git-squash-from
brew tap hanif-mianjee/homebrew-git-squash-from
brew install git-squash-from
```

## Usage

To squash the last 5 commits, use:

```bash
git-squash-from 5
```

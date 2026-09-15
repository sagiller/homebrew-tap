# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.1.0"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.0/datacode-darwin-arm64.zip"
      sha256 "b48da795f365f4c370c04e5acb85ce639e09f88840baf227e7d84b9ebb18f5ae"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.0/datacode-darwin-x64.zip"
      sha256 "606a231a05105d99cc718dfc0279d764a0b0ae9566911680a94b36e322211213"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.0/datacode-linux-arm64.tar.gz"
      sha256 "017d8d99a02cff91a96a683eb6295aa9b4546293db660fdd9bd60891f5c81fca"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.0/datacode-linux-x64.tar.gz"
      sha256 "8df12adf3093f80d0cf891b79bc806171557b2290d903fe9f489e116f92d929f"
    end
  end

  def install
    libexec.install Dir["bin/*"]
    prefix.install "LICENSE"
    (bin/"datacode").write <<~SH
      #!/bin/sh
      export KILO_TREE_SITTER_WASM_DIR="#{libexec}/tree-sitter"
      export DATACODE_INSTALL_METHOD="brew"
      if [ "$1" = "upgrade" ]; then
        echo "DataCode is managed by Homebrew. Run: brew upgrade datacode" >&2
        exit 1
      fi
      exec "#{libexec}/datacode" "$@"
    SH
    (bin/"datacode").chmod 0755
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/datacode --version")
  end
end

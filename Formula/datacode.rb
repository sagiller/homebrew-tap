# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.3.0"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.0/datacode-darwin-arm64.zip"
      sha256 "49c86b610336074dfb035485789a3e9a05d66b9ad6eb41a20f47c2aa7bc2d054"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.0/datacode-darwin-x64.zip"
      sha256 "e3878ae7f4a5c86300436a1ffc765ad9c5d9aac16490c4de0faa33baf4389031"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.0/datacode-linux-arm64.tar.gz"
      sha256 "2bc79f8eb5f1bfcab8cc2a8c5a6a88a83a7c5938631c59b640a6450f65ace550"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.0/datacode-linux-x64.tar.gz"
      sha256 "2e1b1573e7e7308b72b5a0befe81460085af3f2c23e50c598f42c22731305869"
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

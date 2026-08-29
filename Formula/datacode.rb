# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.0.6"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.6/datacode-darwin-arm64.zip"
      sha256 "6b0196df034629a9eb1b2f8a282d1c110a23febca3117f7c75271e979fb05863"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.6/datacode-darwin-x64.zip"
      sha256 "3f790749938f2aefac742360137b17a91375c6bebca4742218054f0fec538a5c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.6/datacode-linux-arm64.tar.gz"
      sha256 "08c10c6866e1637c10e5de7b4f7b348ea73bfb033897a551a2972437450bab7d"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.6/datacode-linux-x64.tar.gz"
      sha256 "0513848e9010eaed090f616c5e5fde7cd1fd183ee305552c351c26a649c82fff"
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

# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.0.8"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.8/datacode-darwin-arm64.zip"
      sha256 "fb0827977957f4ed36ac22caa2c220f1656e546d172af7d75ec953d0b08b3bd5"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.8/datacode-darwin-x64.zip"
      sha256 "50b81f7a4b6f289d5e69c7e7b9eac34a4152535443e8ee257c5b908dad08d6a4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.8/datacode-linux-arm64.tar.gz"
      sha256 "18146809d74b0353f8995a0fd688b392ae35034685bc313cafeae14f317843a3"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.8/datacode-linux-x64.tar.gz"
      sha256 "3146296617563a013494dac1575d5793d81d51a7ee979765d0564ed0a15b68b9"
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

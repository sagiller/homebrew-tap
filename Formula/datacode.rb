# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.0.11"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.11/datacode-darwin-arm64.zip"
      sha256 "fca0fca12384d59d31e8cefc91fe4362ab92a62431c5328a7a3f9dbbe852a2b2"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.11/datacode-darwin-x64.zip"
      sha256 "7c1c392a884ae32f33031e8099ec5c9479aeb85be8b57e5964a9228c6e469655"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.11/datacode-linux-arm64.tar.gz"
      sha256 "f4bab14e8161e09d808df5376a9ce5d05cc70fd04e4b2f0815b92d605e9c48e8"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.11/datacode-linux-x64.tar.gz"
      sha256 "a20b30c306cfcbf2c5f2bdd8620b78c054180b0e2f15718ca2c4b4938fd6dc8a"
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

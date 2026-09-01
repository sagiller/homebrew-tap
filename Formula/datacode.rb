# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.0.9"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.9/datacode-darwin-arm64.zip"
      sha256 "fc014ef9f951017a15d92cbb0e6d8ffe94fa1fe4e1c78ab198dbf357601f0ad5"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.9/datacode-darwin-x64.zip"
      sha256 "570b7c91ec41337d6a381c0d47e8c3123362288b773cc062dc00683ec7b178c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.9/datacode-linux-arm64.tar.gz"
      sha256 "c67add1b66706d41b0527f1cd4659d381e0e0e40a27274a5c5cda25f04dbe814"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.9/datacode-linux-x64.tar.gz"
      sha256 "8f8b6f20662d19778fcca67048bd0cb83fce2d5a3759eb244954e542cb38abd0"
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

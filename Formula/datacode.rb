# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.1.1"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.1/datacode-darwin-arm64.zip"
      sha256 "3eebf717cb92b5e39f137bb708e12e8261d10633472fdf823e37dc658797eb95"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.1/datacode-darwin-x64.zip"
      sha256 "912f69341c625eba5db33d0c83ff48e724a8db6a43a4f5c81270037adb86ee43"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.1/datacode-linux-arm64.tar.gz"
      sha256 "ec9d90b465f05ac2d35b0d84bf811912a1ec33a47a7cde6ce77df04b664fe473"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.1.1/datacode-linux-x64.tar.gz"
      sha256 "4007c0e1f0b7ab62ee49528667d2f3679590fb712bf38de68ee2b63d6e104d0a"
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

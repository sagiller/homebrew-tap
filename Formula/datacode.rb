# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.0.7"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.7/datacode-darwin-arm64.zip"
      sha256 "ccf70d779a9a092fdf8eb79512e2fe784d59c855cb66cb9e5fcec4a534181512"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.7/datacode-darwin-x64.zip"
      sha256 "a7d53b424fca8fa1bc66c370a14c5ed60e9551c0d53fd2981dbcd19f62f14926"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.7/datacode-linux-arm64.tar.gz"
      sha256 "ca85c8a4e25e9c184931310e0386950e257157f12cea516e33602196ee7b19d6"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.7/datacode-linux-x64.tar.gz"
      sha256 "c4519f8c32c9113a49b1c6009efe4c39d91677c4ca1ee2baaa7f787766d1f5fd"
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

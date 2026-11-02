# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.3.1"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.1/datacode-darwin-arm64.zip"
      sha256 "6ba7c6e25fdd538bda5a300124d1856759e74d8df0b1639f4c8f99109082bdec"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.1/datacode-darwin-x64.zip"
      sha256 "31b02fdebfb3bde42bbca539a314c9e37a531d348d1e180bc6f0c05f8bd189ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.1/datacode-linux-arm64.tar.gz"
      sha256 "7e85e7232b407be961307046836f1ba590e182bec8337d6d6429eed5b7c207fd"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.3.1/datacode-linux-x64.tar.gz"
      sha256 "94e6aeaa3b3a7a87d4d70b4ba480e001218de9fb92e761eb18fb67555570cf07"
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

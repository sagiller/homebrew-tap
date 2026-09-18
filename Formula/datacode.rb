# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.2.0"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.0/datacode-darwin-arm64.zip"
      sha256 "f8d499856f124093d6264f836bb42f73a1c16ef26849668d0d9e4f0c855790c5"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.0/datacode-darwin-x64.zip"
      sha256 "2671687ca7d17aa32a8a6963df633cb9969a8fe07c1dde9e2b30a47831ef7a3a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.0/datacode-linux-arm64.tar.gz"
      sha256 "750ab8298d84be143cc0fe7af800a51ae9d5282f28e0c6d1fbb17407a343d194"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.0/datacode-linux-x64.tar.gz"
      sha256 "0bc66520835b4a8bd5a37677045a9f6964f9e1cb0ac36045385ef0a338878907"
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

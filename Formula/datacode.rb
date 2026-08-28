# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.5/datacode-darwin-arm64.zip"
      sha256 "cd8b2c66a60e6921465078301627d7114f2f73e629441fc093103bb635f5d1ad"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.5/datacode-darwin-x64.zip"
      sha256 "efe92f57f4acf91260f3106d369e99b81cf887175b073fcb8a078e00ef640271"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.5/datacode-linux-arm64.tar.gz"
      sha256 "57e4a6a822f14af594c26d779825f397208d5327ff77f3c8ff46e9412ee3b303"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.0.5/datacode-linux-x64.tar.gz"
      sha256 "f7d4952c79fc9d72e1d73712999e52e4a7375be131fb9e780f11bfc04bb7b4db"
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

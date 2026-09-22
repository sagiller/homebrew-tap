# typed: false
# frozen_string_literal: true

# Generated from the immutable DataCode Runtime manifest. Do not edit manually.
class Datacode < Formula
  desc "AI coding agent for the terminal"
  homepage "https://github.com/sagiller/datacode-releases"
  license "MIT"
  version "1.2.1"

  depends_on "ripgrep"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.1/datacode-darwin-arm64.zip"
      sha256 "6876faa58cc82c94614eec2f7692f3a3e8cee30d9a65634d9ab2b26a1b94bc15"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.1/datacode-darwin-x64.zip"
      sha256 "74a23de45d7bc705b9e810e8396bcbce8bd97c0c536201d1fc6b1c6eaa5334ec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.1/datacode-linux-arm64.tar.gz"
      sha256 "249c49d8c1a8dcbf689a890b7995f49df7ef9a59211e88d6d0279f7013805e15"
    else
      url "https://github.com/sagiller/datacode-releases/releases/download/v1.2.1/datacode-linux-x64.tar.gz"
      sha256 "a4f39eae01a4c9951e628aecd4e10ab93bf84e94fb19e007348313f4df0d5524"
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

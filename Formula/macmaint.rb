class Macmaint < Formula
  desc "AI-powered CLI maintenance agent for macOS"
  homepage "https://github.com/nusretmemic/macmaint"
  url "https://github.com/nusretmemic/macmaint/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "433e234bb2edffb6ba11f66fdc8e7aeebc616e2cc6925b7e78798fa87d42f2be"
  license "MIT"

  depends_on "pipx"

  def install
    system "pipx", "install", "--force", "git+https://github.com/nusretmemic/macmaint.git@v0.1.0"
  end

  def post_install
    system "pipx", "ensurepath"
  end

  def caveats
    <<~EOS
      To use MacMaint, you need to:
      1. Run 'macmaint init' to set up your configuration
      2. Provide your OpenAI API key when prompted

      Configuration will be stored in: ~/.macmaint/
      
      Note: You may need to restart your terminal for the macmaint command to be available in your PATH.
    EOS
  end

  test do
    system "macmaint", "--help"
  end
end

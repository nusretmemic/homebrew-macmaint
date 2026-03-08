class Macmaint < Formula
  include Language::Python::Virtualenv

  desc "AI-powered CLI maintenance agent for macOS"
  homepage "https://github.com/nusretmemic/macmaint"
  url "https://github.com/nusretmemic/macmaint/archive/refs/heads/master.tar.gz"
  sha256 "3acd46cd438f64b0e495e0b9c0c35a4c742199f1ade18dc9a07ce1c3a4a44904"
  license "MIT"
  version "0.3.0"

  depends_on "python@3.12"

  def install
    # Get python path
    python = Formula["python@3.12"].opt_bin/"python3.12"
    
    # Create virtualenv with pip
    system python, "-m", "venv", libexec
    
    # Install dependencies
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "click>=8.1.0", "rich>=13.0.0", 
           "psutil>=5.9.0", "openai>=1.0.0", "pydantic>=2.0.0", 
           "pyyaml>=6.0.0", "python-dotenv>=1.0.0"
    
    # Install the package
    system libexec/"bin/pip", "install", "--no-deps", buildpath
    
    # Create symlink
    bin.install_symlink libexec/"bin/macmaint"
  end

  def caveats
    <<~EOS
      To use MacMaint, you need to:
      1. Run 'macmaint init' to set up your configuration
      2. Provide your OpenAI API key when prompted

      Configuration will be stored in: ~/.macmaint/
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/macmaint --help")
  end
end

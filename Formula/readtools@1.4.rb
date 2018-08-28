class ReadtoolsAT14 < Formula
  desc "Handling Sequence Data from Different Sequencing Platforms"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.4.1/ReadTools.jar"
  sha256 "7092f3de1de6eb24023b1a73a0e362feebc98145ad07310ef5c0293fe2934635"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install "ReadTools.jar"
    bin.write_jar_script Dir[libexec/"ReadTools.jar"][0], "readtools", "${JAVA_OPTS}"
  end

  def caveats
    <<~EOS
      To pass java options to the readtools wrapper, use the environment variable JAVA_OPTS.
        Example: JAVA_OPTS="-Xmx4g" readtools
    EOS
  end

  test do
    assert_match "USAGE", shell_output("java -jar #{libexec}/ReadTools.jar -h 2>&1")
    assert_match "USAGE", shell_output("#{bin}/readtools -h 2>&1")
  end
end

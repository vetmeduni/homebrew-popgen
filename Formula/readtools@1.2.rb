class ReadtoolsAT12 < Formula
  desc "Handling Sequence Data from Different Sequencing Platforms"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.2.1/ReadTools.jar"
  sha256 "7b0c03002377ecf12dcd22766b2e1ec1dadf0e46b4868a2938075b5c4686de7a"

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

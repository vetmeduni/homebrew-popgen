class Readtools < Formula
  desc "Handling Sequence Data from Different Sequencing Platforms"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.5.2/ReadTools.jar"
  sha256 "5eb785870cc37bd6359191d2795b0387e340c26e1b2a80653cb71cc31591137e"

  head { url "https://github.com/magicDGS/ReadTools.git" }

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    if build.head?
      system "./gradlew", "currentJar"
      libexec.install "build/libs/ReadTools.jar"
    else
      libexec.install "ReadTools.jar"
    end
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

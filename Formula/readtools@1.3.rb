class ReadtoolsAT13 < Formula
  desc "Handling Sequence Data from Different Sequencing Platforms"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.3.0/ReadTools.jar"
  sha256 "2c8062c511b26c3dd82e3a8cd0c8dfd0af985e8e70cc994f863167ebcd8bd013"

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
    assert_match "USAGE", shell_output("java -jar #{libexec}/ReadTools.jar -h 2>&1", 0)
    assert_match "USAGE", shell_output("#{bin}/readtools -h 2>&1", 0)
  end
end

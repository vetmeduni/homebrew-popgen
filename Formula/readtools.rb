class Readtools < Formula
  desc "Handling Sequence Data from Different Sequencing Platforms"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.5.1/ReadTools.jar"
  sha256 "0ceb7e1df9b9d466175a9053c1a2127cd4450871a4dc9ab1537c65735a773150"

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

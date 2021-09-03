class Popte2 < Formula
  desc "Comparative population genomics of transposable elements"
  homepage "https://sourceforge.net/projects/popoolation-te2/"
  url "https://downloads.sourceforge.net/project/popoolation-te2/previous-releases/popte2-v1.10.04.jar"
  sha256 "58798c37ed3ff7d5f24d44af3108af485298fbea0eba1a27e535af2e6ff1bb5a"

  bottle :unneeded

  depends_on "java"

  def install
    java = share/"java"
    java.install Dir["*.jar"]
    bin.write_jar_script java/"popte2-v1.10.04.jar", "popte2"
    inreplace "#{bin}/popte2", "exec java ", "exec java ${JAVA_OPTS:--Xmx4g}"
  end

  def caveats
    <<-EOS.undent
      The PoPoolationTE2 JAR file is installed to
        #{HOMEBREW_PREFIX}/share/java
      and is meant to be called via the "popte2" launch script.
      Pass java options via the environment variable JAVA_OPTS.
    EOS
  end

  test do
    assert_match "USAGE", shell_output("java -jar #{share}/java/popte2-v1.10.04.jar -h 2>&1", 1)
    assert_match "USAGE", shell_output("#{bin}/popte2 -h 2>&1", 1)
  end
end

class Readtools < Formula
  desc "Standardizing sources for sequencing data"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.0.0/ReadTools.jar"
  sha256 "f87e1c0df65680a17471e20f98155d11c3ff58f06ab8ea295ff8808f21f695a4"

  bottle :unneeded

  depends_on :java

  def install
    java = share/"java"
    java.install Dir["*.jar"]
    bin.write_jar_script java/"ReadTools.jar", "readtools"
  end

  def post_install
    inreplace "#{bin}/readtools", "exec java ", "exec java ${JAVA_OPTS}"
  end

  def caveats
    <<-EOS.undent
      The ReadTools JAR files are installed to
        #{HOMEBREW_PREFIX}/share/java

      Pass java options via the environment variable JAVA_OPTS
    EOS
  end

  test do
    assert_match "USAGE", shell_output("java -jar #{share}/java/ReadTools.jar -h 2>&1", 1)
    assert_match "USAGE", shell_output("#{bin}/readtools -h 2>&1", 1)
  end
end

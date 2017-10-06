class Readtools < Formula
  desc "Standardizing sources for sequencing data"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.1.0/ReadTools.jar"
  sha256 "c9a2da72291928ad28ef80c31a9f0d464ed681ba62b18e23e12cee58fb25546e"

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

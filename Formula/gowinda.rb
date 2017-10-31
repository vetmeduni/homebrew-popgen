class Gowinda < Formula
  desc "Unbiased analysis of gene set enrichment for genome-wide association studies"
  homepage "https://sourceforge.net/projects/gowinda/"
  url "https://downloads.sourceforge.net/project/gowinda/Gowinda-1.12.jar"
  sha256 "bbbb462dbb28e04eff826fa97885c2ac962c4a111fe693e157b017cb2d1df0b2"

  bottle :unneeded

  depends_on :java => ["1.8", :run]

  def install
    java = share/"java"
    java.install Dir["*.jar"]
    bin.write_jar_script java/"Gowinda-1.12.jar", "gowinda"
    inreplace "#{bin}/gowinda", "exec java ", "exec java ${JAVA_OPTS}"
  end

  def caveats
    <<-EOS.undent
      The Gowinda JAR file is installed to
        #{HOMEBREW_PREFIX}/share/java
      and is meant to be called via the "gowinda" launch script.
      Pass java options via the environment variable JAVA_OPTS.
    EOS
  end

  test do
    assert_match "USAGE", shell_output("java -jar #{share}/java/Gowinda-1.12.jar --version 2>&1", 1)
    assert_match "USAGE", shell_output("#{bin}/gowinda --version 2>&1", 1)
  end
end

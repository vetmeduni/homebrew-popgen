class Mimicree < Formula
  desc "Forward simulations of entire genomes from standing genetic variation"
  homepage "https://sourceforge.net/projects/mimicree/"
  url "https://downloads.sourceforge.net/project/mimicree/mimicree.jar"
  version "1.11"
  sha256 "e9d00ac3f10adcf850b10264681ce4df1070b28180497fca9416c463b0c6596b"

  bottle :unneeded

  depends_on :java => ["1.8", :run]

  def install
    java = share/"java"
    java.install Dir["*.jar"]
    bin.write_jar_script java/"mimicree.jar", "mimicree"
    inreplace "#{bin}/mimicree", "exec java ", "exec java ${JAVA_OPTS:--Xmx4g}"
  end

  def caveats
    <<-EOS.undent
      The mimicree JAR file is installed to
        #{HOMEBREW_PREFIX}/share/java
      and is meant to be called via the "mimicree" launch script.
      Pass java options via the environment variable JAVA_OPTS.
    EOS
  end

  test do
    assert_match "USAGE", shell_output("java -jar #{share}/java/mimicree.jar --version 2>&1", 1)
    assert_match "USAGE", shell_output("#{bin}/mimicree --version 2>&1", 1)
  end
end

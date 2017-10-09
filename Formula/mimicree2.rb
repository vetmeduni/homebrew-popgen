class Mimicree2 < Formula
  desc "Work in progress"
  homepage "https://sourceforge.net/projects/mimicree2/"
  url "https://downloads.sourceforge.net/project/mimicree2/mim2.jar"
  version "0.41"
  sha256 "8c6aed0ad1511a98b9240a3e98ded53ce701d967937eac1edf2980364f616783"

  bottle :unneeded

  depends_on :java => ["1.8", :run]

  def install
    java = share/"java"
    java.install Dir["*.jar"]
    bin.write_jar_script java/"mim2.jar", "mimicree2"
    inreplace "#{bin}/mimicree2", "exec java ", "exec java ${JAVA_OPTS:--Xmx4g}"
  end

  def caveats
    <<-EOS.undent
      The mimicree2 JAR file is installed to
        #{HOMEBREW_PREFIX}/share/java
      and is meant to be called via the "mimicree2" launch script.
      Pass java options via the environment variable JAVA_OPTS.
    EOS
  end

  test do
    assert_match "USAGE", shell_output("java -jar #{share}/java/mim2.jar -h 2>&1", 1)
    assert_match "USAGE", shell_output("#{bin}/mimicree2 -h 2>&1", 1)
  end
end

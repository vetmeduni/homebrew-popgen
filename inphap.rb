class Inphap < Formula
  desc "Interative phased haplotype visualization"
  homepage "http://it.inf.uni-tuebingen.de/?page_id=193"
  url "http://it.informatik.uni-tuebingen.de/software/inPhap/inPHAP_v.1.1.jar"
  sha256 "254a25f80439154fa31f2b34f1319cacce338d50d9d8dfa23f4967fa770af4a5"

  bottle :unneeded

  depends_on :java

  def install
    java = share/"java"
    java.install Dir["*.jar"]
    bin.write_jar_script java/"inPHAP_v1.1.jar", "inphap"
  end

  def post_install
    inreplace "#{bin}/inphap", "exec java ", "exec java ${JAVA_OPTS}"
  end

  def caveats
    <<-EOS.undent
      The inPHAP JAR files are installed to
        #{HOMEBREW_PREFIX}/share/java

      Pass java options via the environment variable JAVA_OPTS
    EOS
  end

  test do
    assert_match "USAGE", shell_output("java -jar #{share}/java/inPHAP_v1.1.jar -h 2>&1", 1)
    assert_match "USAGE", shell_output("#{bin}/inphap -h 2>&1", 1)
  end
end

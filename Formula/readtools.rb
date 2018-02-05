class Readtools < Formula
  desc "Handling Sequence Data from Different Sequencing Platforms"
  homepage "https://magicdgs.github.io/ReadTools/"
  url "https://github.com/magicDGS/ReadTools/releases/download/1.2.1/ReadTools.jar"
  sha256 "7b0c03002377ecf12dcd22766b2e1ec1dadf0e46b4868a2938075b5c4686de7a"

  bottle :unneeded

  depends_on :java => "1.8+"

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

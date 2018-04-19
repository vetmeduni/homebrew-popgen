class Gowinda < Formula
  desc "Unbiased analysis of gene set enrichment for GWAs"
  homepage "https://sourceforge.net/projects/gowinda/"
  url "https://downloads.sourceforge.net/project/gowinda/Gowinda-1.12.jar"
  sha256 "bbbb462dbb28e04eff826fa97885c2ac962c4a111fe693e157b017cb2d1df0b2"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install Dir["Gowinda-*.jar"][0]
    bin.write_jar_script Dir[libexec/"Gowinda-*.jar"][0], "gowinda", "${JAVA_OPTS}"
  end

  def caveats
    <<~EOS
      To pass java options to the "gowinda" wrapper, use the environment variable JAVA_OPTS.
        Example: JAVA_OPTS="-Xmx4g" gowinda
    EOS
  end

  test do
    assert_match "Gowinda", shell_output("#{bin}/gowinda --help 2>&1", 1)
  end
end

class Mimicree2 < Formula
  desc "Mimicing Experimental Evolution 2 (work in progress)"
  homepage "https://sourceforge.net/projects/mimicree2/"
  url "https://downloads.sourceforge.net/project/mimicree2/versions/mim2-v199.jar"
  version "0.19.9"
  sha256 "bc35350c693686c47580afa61f842f8b2a618be6ed4fe432725bfc30d31b167b"

  bottle :unneeded

  depends_on :java => ["1.8", :run]

  def install
    libexec.install Dir["mim2-*.jar"][0]
    bin.write_jar_script Dir[libexec/"mim2-*.jar"][0], "mimicree2", "${JAVA_OPTS:--Xmx4g}"
  end

  def caveats
    <<~EOS
      To pass and overwrite java options to the "mimicree2" wrapper,
      use the environment variable JAVA_OPTS (default to --Xmx4g)
        Example: JAVA_OPTS="-Xmx10g" mimicree2
    EOS
  end

  test do
    assert_match "Usage", shell_output("java -jar #{libexec}/mim2-*.jar --version 2>&1", 1)
    assert_match "Usage", shell_output("#{bin}/mimicree2 --version 2>&1", 1)
    assert_match "0 tests failed", shell_output("#{bin}/mimicree2 unit-tests 2>&1", 0)
  end
end

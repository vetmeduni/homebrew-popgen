class Mimicree < Formula
  desc "Forward simulations of entire genomes from standing genetic variation"
  homepage "https://sourceforge.net/projects/mimicree/"
  url "https://downloads.sourceforge.net/project/mimicree/mimicree.jar"
  version "1.11"
  sha256 "e9d00ac3f10adcf850b10264681ce4df1070b28180497fca9416c463b0c6596b"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install "mimicree.jar"
    bin.write_jar_script Dir[libexec/"mimicree.jar"][0], "mimicree", "${JAVA_OPTS:--Xmx4g}"
  end

  def caveats
    <<~EOS
      To pass and overwrite java options to the "mimicree" wrapper,
      use the environment variable JAVA_OPTS (default to --Xmx4g)
        Example: JAVA_OPTS="-Xmx10g" mimicree
    EOS
  end

  test do
    assert_match "MimicrEE", shell_output("#{bin}/mimicree --version 2>&1")
  end
end

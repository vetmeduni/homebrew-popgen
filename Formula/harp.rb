class Harp < Formula
  desc "Haplotype Analysis of Reads in Pools"
  homepage "https://bitbucket.org/dkessner/harp"
  # TODO: implement option for download and install linux?
  url "https://bitbucket.org/dkessner/harp/downloads/harp_osx_140925_100959.zip"
  # changed _ to - because of brew audit (should not end with an underline and a number)
  version "140925-100959"
  sha256 "81706020128b5c2cce3bcc8b7c3c32a43ca471660343e7c873e81aee14bf7cc8"

  def install
    # install binaries
    bin.install Dir["bin/*"]
    # install documentation
    doc.install "README"
    doc.install "harp_docs.pdf"
  end

  def caveats
    <<~EOS
      Some modules are missing (e.g., simreads) becaue it only contains
      pre-compiled binaries: harp, index_snp_table and qual_hist_fastq.

      Documentation can be found in #{doc}
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/harp", 1)
    assert_match "Usage", shell_output("#{bin}/index_snp_table", 1)
    assert_match "Usage", shell_output("#{bin}/qual_hist_fastq", 1)
  end
end

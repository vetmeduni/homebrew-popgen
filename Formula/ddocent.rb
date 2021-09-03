class Ddocent < Formula
  desc "Bash pipeline for RAD sequencing"
  homepage "http://ddocent.com"
  url "https://github.com/jpuritz/dDocent/archive/v2.2.16.tar.gz"
  sha256 "fdf298b65f3cc999a179bba96927466cecfdfaf6ff53f60dc4fb6665b0395e1d"

  depends_on "bamtools"
  depends_on "bedtools"
  depends_on "bwa"
  depends_on "cd-hit"
  depends_on "freebayes"
  depends_on "gnuplot"
  depends_on "java"
  depends_on "mawk"
  depends_on "parallel"
  depends_on "pear"
  depends_on "rainbow"
  depends_on "samtools"
  depends_on "seqtk"
  depends_on "stacks"
  depends_on "trimmomatic"
  depends_on "vcflib"
  depends_on "vcftools"

  def install
    system "sed", "-i.ORIG", 's@${PATH//:/ }\(.*TruSeq.*\)@/usr/local/share/trimmomatic/adapters\1@
s@pearRM@pear@g
s@${PATH//:/ }\(.*trimmomatic.*\)@/usr/local/share/java\1@', "dDocent"
    chmod "+x", "dDocent"
    bin.install "dDocent"
  end

  test do
    system "true"
  end
end

class Ddocent < Formula
  desc "Bash pipeline for RAD sequencing"
  homepage "http://ddocent.com"
  url "https://github.com/jpuritz/dDocent/archive/v2.2.16.tar.gz"
  sha256 "fdf298b65f3cc999a179bba96927466cecfdfaf6ff53f60dc4fb6665b0395e1d"

  # depends_on "freebayes" => :run
  # depends_on "stacks" => :run
  # depends_on "trimmomatic" => :run
  # depends_on "mawk" => :run
  # depends_on "bwa" => :run
  # depends_on "samtools" => :run
  # depends_on "vcftools" => :run
  # depends_on "rainbow" => :run
  # depends_on "seqtk" => :run
  # depends_on "cd-hit" => :run
  # depends_on "bedtools" => :run
  # depends_on "vcflib" => :run
  # depends_on "gnuplot" => :run
  # depends_on "parallel" => :run
  # depends_on "bamtools" => :run
  # depends_on :java => :run
  # depends_on "pear" => :run

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

class Popoolation2 < Formula
  desc "Allows to compare allele frequencies for SNPs between two or more populations and to identify
        significant differences. PoPoolation2 requires next generation sequencing data of pooled genomic
        DNA (Pool-Seq). It may be used for measuring differentiation between populations, for genome wide
        association studies and for experimental evolution."
  homepage "https://sourceforge.net/p/popoolation2/wiki/Main/"
  url "https://downloads.sourceforge.net/project/popoolation2/popoolation2_1201.zip"
  version "1.2.01"
  sha256 "7f45353a211ec88d36fd1beed1d128673f3ff911b731211eb5a39f8602bddd42"

  bottle :unneeded

  depends_on "cpanminus" => :build
  depends_on :perl => ["5.8", :run]
  depends_on :java => ["1.8", :run, :recommended]
  depends_on "r" => [:run, :optional]
  depends_on "samtools" => [:run, :optional]
  depends_on "bwa" => [:run, :optional]

  def install
    rm "mpileup2sync.pl"
    chmod 0755, Dir.glob("*.pl")
    chmod 0755, Dir.glob("export/*.pl")
    chmod 0755, Dir.glob("indel_filtering/*.pl")
    mkdir "foo"
    mv Dir.glob("*.pl"), "foo/"
    mv Dir.glob("*.jar"), "foo/"
    mkdir "foo/export"
    mv Dir["export/*.pl"], "foo/export/"
    mkdir "foo/indel_filtering"
    mv Dir["indel_filtering/*.pl"], "foo/indel_filtering/"
    mkdir "foo/Modules"
    mv Dir["Modules/*.pm"], "foo/Modules/"
    mkdir "foo/Modules/Test"
    mv Dir["Modules/Test/*.pm"], "foo/Modules/Test/"
    mkdir "bar"
    system "cpanm", "-L", "bar", "Text::NSP::Measures::2D::Fisher::twotailed"
    mv "bar/lib/perl5/Text", "foo/Modules/"
    File.write("ppool2", <<-EOS.undent)
      \#!/bin/bash
      atom="$1"
      if [ "x$atom" != "x" ]; then
        shift
        if [ "$atom" = "mpileup2sync" ]; then
          exec java ${JAVA_OPTS} -jar #{pkgshare}/mpileup2sync.jar "$@"
        else
          case "${atom}" in
            "cmh-test"|"create-genewise-sync"|"fisher-test"|"fst-sliding"|"mpileup2sync"|\\
            "snp-frequency-diff"|"subsample-synchronized"|"synchronize-pileup"|\\
            "export/cmh2gwas"|"export/pwc2igv"|"export/subsample_sync2GenePop"|"export/subsample_sync2fasta"|\\
            "indel_filtering/filter-sync-by-gtf"|"indel_filtering/identify-indel-regions")
              script=#{pkgshare}/${atom}.pl
              exec ${script} "$@"
              ;;
          esac
        fi
      fi
      echo "Usage: $0 <command> <arguments>

            where <command> is one of

              help
              cmh-test
              create-genewise-sync
              fisher-test
              fst-sliding
              mpileup2sync
              snp-frequency-diff
              subsample-synchronized
              synchronize-pileup
              export/cmh2gwas
              export/pwc2igv
              export/subsample_sync2GenePop
              export/subsample_sync2fasta
              indel_filtering/filter-sync-by-gtf
              indel_filtering/identify-indel-regions

           See https://sourceforge.net/p/popoolation2/wiki/Main/ for details."
    EOS
    bar=share/"popoolation2"
    bar.install Dir["foo/*"]
    bin.install "ppool2"
  end

  def caveats
    <<-EOS.undent
      Please cite as:

        Kofler R, Vinay Pandey R, Schloetterer C. PoPoolation2: Identifying differentiation between
        populations using sequencing of pooled DNA samples (Pool-Seq). Bioinformatics 27, 3435–3436 (2011)
        https://doi.org/10.1093/bioinformatics/btr589

      You may also be interested in our Pool-seq review (Nature Reviews Genetics) where we provide some
      recommendations for the analysis of Pool-seq data: https://doi.org/10.1038/nrg3803
    EOS
  end

  test do
    system "#{bin}/ppool2", "cmh-test", "--test"
  end
end

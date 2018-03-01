class Popoolation2 < Formula
  desc "Identifying differentiation between populations using Pool-Seq"
  homepage "https://sourceforge.net/p/popoolation2/wiki/Main/"
  url "https://downloads.sourceforge.net/project/popoolation2/popoolation2_1201.zip"
  version "1.2.01"
  sha256 "7f45353a211ec88d36fd1beed1d128673f3ff911b731211eb5a39f8602bddd42"

  bottle :unneeded

  depends_on "cpanminus" => :build
  depends_on "perl" => :run
  depends_on :java => ["1.8", :run]

  def install
    # remove the slow version of mpileup2sync
    rm "mpileup2sync.pl"
    # remove java source code
    rm Dir.glob("Modules/javasrc/*.java")

    # make perl scripts runnable
    chmod 0755, Dir.glob("*.pl")
    chmod 0755, Dir.glob("export/*.pl")
    chmod 0755, Dir.glob("indel_filtering/*.pl")

    # install in pkgshare teh perl scripts, runnable java and modules
    pkgshare.install Dir.glob("*.pl")
    pkgshare.install Dir.glob("*.jar")
    pkgshare.install "export"
    pkgshare.install "indel_filtering"
    pkgshare.install "Modules"

    # install the required module in a tmp directory and install it to package share Modules folder
    mkdir "tmp"
    system "cpanm", "-L", "tmp", "Text::NSP::Measures::2D::Fisher::twotailed"
    mv "tmp/lib/perl5/Text", pkgshare/"Modules/"

    # create the launcher script
    File.write("popoolation2", <<~EOS)
      \#!/bin/bash
      atom="$1"
      if [ "$atom" != "" ]; then
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

          See https://sourceforge.net/p/popoolation2/wiki/Main/ for arguments.

          Please cite as:

            Kofler R, Vinay Pandey R, Schloetterer C. PoPoolation2: Identifying differentiation between
            populations using sequencing of pooled DNA samples (Pool-Seq). Bioinformatics 27, 3435–3436 (2011)
            https://doi.org/10.1093/bioinformatics/btr589

          You may also be interested in our Pool-seq review (Nature Reviews Genetics) where we provide some
          recommendations for the analysis of Pool-seq data: https://doi.org/10.1038/nrg3803"
    EOS
    bin.install "popoolation2"
  end

  def caveats
    <<~EOS
      The PoPoolation2 files are installed to #{pkgshare}
      and meant to be called via the "popoolation2" launch script.

      The mpileup2sync command is using the faster java version.
      You may pass java options to this command via JAVA_OPTS.
    EOS
  end

  test do
    shell_output("#{bin}/popoolation2 cmh-test --test", 0)
  end
end

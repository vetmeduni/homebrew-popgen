class Augustus < Formula
  desc "Predict genes in eukaryotic genomic sequences"
  homepage "http://bioinf.uni-greifswald.de/augustus/"
  url "http://bioinf.uni-greifswald.de/augustus/binaries/augustus-3.3.1.tar.gz"
  sha256 "e0249bff0345f6a790b5c56432f292040254457da22f1a2c212f42d7d2104087"
  revision OS.mac? ? 1 : 3

  depends_on "bamtools"
  depends_on "boost"
  unless OS.mac?
    depends_on "bamtools"
    depends_on "zlib"
  end

  def install
    # Fix error: api/BamReader.h: No such file or directory
    inreplace "auxprogs/bam2hints/Makefile",
      "INCLUDES = /usr/include/bamtools",
      "INCLUDES = #{Formula["bamtools"].include/"bamtools"}"
    inreplace "auxprogs/filterBam/src/Makefile",
      "BAMTOOLS = /usr/include/bamtools",
      "BAMTOOLS= #{Formula["bamtools"].include/"bamtools"}"
    # idiot code wants samtools internal lib
    system "git", "clone", "https://github.com/samtools/samtools.git"
    cd "samtools"
    system "autoheader"
    system "autoconf", "-Wno-syntax"
    system "./configure", "--with-htslib=#{Formula["htslib"].prefix}"
    system "make"
    cd ".."
    # Fix bam2wig errors
    inreplace "auxprogs/bam2wig/Makefile",
      "SAMTOOLS=$(TOOLDIR)/samtools",
      "SAMTOOLS=#{buildpath}/samtools"
    inreplace "auxprogs/bam2wig/Makefile",
      "HTSLIB=$(TOOLDIR)/htslib",
      "HTSLIB=#{Formula["htslib"].include/"htslib"}"
    inreplace "auxprogs/bam2wig/Makefile",
      "LIBS=$(SAMTOOLS)/libbam.a $(HTSLIB)/libhts.a",
      "LIBS=$(SAMTOOLS)/libbam.a -lhts"

    # Prevent symlinking into /usr/local/bin/
    inreplace "Makefile", %r{ln -sf.*/usr/local/bin/}, "#ln -sf"

    # Compile executables for macOS. Tarball ships with executables for Linux.
    system "make", "clean"
    system "make"

    system "make", "install", "INSTALLDIR=#{prefix}"
    bin.env_script_all_files libexec/"bin", :AUGUSTUS_CONFIG_PATH => prefix/"config"
  end

  test do
    (testpath/"test.fasta").write <<~EOS
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    cmd = "#{bin}/augustus --species=human test.fasta"
    assert_match "Predicted genes", shell_output(cmd)
  end
end

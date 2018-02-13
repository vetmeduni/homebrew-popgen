class Art < Formula
  desc "Set of Simulation Tools to generate synthetic sequencing reads"
  homepage "https://www.niehs.nih.gov/research/resources/software/biostatistics/art/index.cfm"
  # TODO: implement option for download and install 64-bits
  url "https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier20160605macos32tgz.tgz"
  version "MountRainier-2016-06-05"
  sha256 "2a56774637712fc60ecef8e01c4d1f532069a01f03109a20d7f1624491243209"

  # Options
  option "with-profilers", "Install also the binaries for profile generators (454 and Illumina)"
  # optional dependency for the perl scripts
  depends_on "perl" => :optional

  

  def install
    # add the binaries
    bin.install ["art_454", "art_SOLiD", "art_illumina"]
    # add the perl scripts to the libexec
    libexec.install Dir["*.pl"]
    # add the READMEs
    doc.install Dir["*README.txt"]

    # install the profilers if requested
    if build.with? "profilers"
      # add the binaries
      bin.install Dir["ART_profiler_*/art_profiler_*"]
      # add the perl scripts
      libexec.install Dir["ART_profiler_*/*.pl"]
      # add the READMEs
      doc.install Dir["ART_profiler_*/README"]
    end

    # symlink the perl scripts if --wit-perl is specified
    if build.with? "perl"
      Pathname.glob("#{libexec}/*.pl") do |script|
        bin.install_symlink script => "art_" + script.basename
      end
    end

  end

  def caveats
    <<~EOS
      Perl scripts from the ART package are installed in #{libexec}
      and a symlink created in the #{bin} with an "art_" prefix
      to avoid clashes with other software if --with-perl is specified.
    EOS
  end

  test do
    assert_match "ART_SOLiD", shell_output("#{bin}/art_SOLiD 2>&1", 1)
    assert_match "ART_Illumina", shell_output("#{bin}/art_illumina 2>&1", 1)
    # for whatever reason, art_454 returns 0 without arguments
    assert_match "ART_454", shell_output("#{bin}/art_454 2>&1", 0)
  end

end

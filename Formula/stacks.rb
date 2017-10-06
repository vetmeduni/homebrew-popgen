class Stacks < Formula
  desc "Pipeline for building loci from short-read sequences"
  homepage "http://catchenlab.life.illinois.edu/stacks/"
  # doi "10.1111/mec.12354"
  # tag "bioinformatics

  url "http://catchenlab.life.illinois.edu/stacks/source/stacks-1.46.tar.gz"
  sha256 "45a0725483dc0c0856ad6b1f918e65d91c1f0fe7d8bf209f76b93f85c29ea28a"

  option "with-optimize", "Disable debug and turn on aggressive optimization"

  if MacOS.version < :mavericks
    depends_on "google-sparsehash" => [:recommended, "c++11"]
  else
    depends_on "google-sparsehash" => :recommended
  end

  depends_on :perl => ["5.10", :run, :recommended]
  depends_on :mysql => [:run, :recommended]

  fails_with :clang

  def install
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}"]
    args << "--enable-sparsehash" if build.with? "google-sparsehash"
    args << "CXXFLAGS=-O3 -march=native -mtune=native" if build.with? "optimize"

    system "./configure", *args
    if build.with? "optimize"
      cd "htslib"
      system "make", "CFLAGS=-O3 -march=native -mtune=native"
      cd ".."
    end
    system "make"
    system "make", "install"
  end

  def caveats
    <<-EOS.undent
      For instructions on setting up the web interface:
          #{prefix}/README

      The PHP and MySQL scripts have been installed to:
          #{share}
    EOS
  end

  test do
    system "#{bin}/ustacks", "--version"
  end
end

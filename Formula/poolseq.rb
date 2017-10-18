class Poolseq < Formula
  desc "Analyze and simulate Pool-Seq time series data"
  homepage "https://github.com/ThomasTaus/poolSeq/"
  url "https://github.com/ThomasTaus/poolSeq/releases/download/v0.3.1/poolSeq_0.3.1.tar.gz"
  sha256 "a38a1a0d79ec16ba6ec9227d3f61f037154146e1b882940ca013f8f98db43eb3"

  bottle :unneeded

  depends_on "r"

  # R package installation method copied from package "nonpareil"
  def install
    r_library = lib/"R"/r_major_minor/"site-library"
    r_library.mkpath
    File.write("install-poolSeq.r", <<-EOS.undent)
      dependencies=c("data.table","foreach","stringi","matrixStats")
      options(repos=c(CRAN="https://cloud.r-project.org/"))
      for (dep in dependencies)
      {
        if (!library(dep,character.only=TRUE,logical.return=TRUE))
          install.packages(dep,lib="#{r_library}")
        else
          update.packages(dep)
      }
      install.packages("#{HOMEBREW_CACHE}/#{name}-#{version}.tar.gz",repos=NULL,type="source",lib="#{r_library}")
      EOS
    system "Rscript", "install-poolSeq.r"
  end

  def r_major_minor
    `#{Formula["r"].bin}/Rscript -e 'cat(as.character(getRversion()[1,1:2]))'`.strip
  end

  def caveats
    <<-EOS.undent
      Also installed any missing R package dependencies as part of this package.
      They will be removed when you "brew uninstall" this package.
    EOS
  end

  test do
    system "Rscript", "-e", 'if (library(poolSeq,logical.return=TRUE)) q("no",0) else q("no",11)'
  end
end

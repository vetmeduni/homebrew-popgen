class Poolseq < Formula
  desc "Analyze and simulate Pool-Seq time series data"
  homepage "https://github.com/ThomasTaus/poolSeq/"
  url "https://github.com/ThomasTaus/poolSeq/releases/download/v0.3.1/poolSeq_0.3.1.tar.gz"
  sha256 "a38a1a0d79ec16ba6ec9227d3f61f037154146e1b882940ca013f8f98db43eb3"

  bottle :unneeded

  # R is not really optional, but may not be managed by Homebrew
  depends_on "r" => :optional

  def install
    require "English"
    File.write("install-poolSeq.r", <<-EOS.undent)
      dependencies=c("data.table","foreach","stringi","matrixStats")
      chooseCRANmirror()
      for (dep in dependencies)
        if (!library(dep,logical.return=TRUE)) install.packages(dep)
      install.packages("#{HOMEBREW_CACHE}/#{name}-#{version}.tar.gz",repos=NULL,type="source")
      EOS
    system "Rscript", "install-poolSeq.r"
    $CHILD_STATUS.exitstatus.nil &&
      raise("R may be missing or not in your PATH. To install R, use the --with-r option.")
  end

  def caveats
    <<-EOS.undent
      This installer just called R's install.packages() function and did not
      install any files itself. "brew uninstall" will only remove the entry in
      Homebrew's list of installed packages, but not the actual R package.

      This installer installed missing dependencies, but did not update them
      if they were already installed. You might want to call R's update.packages().
    EOS
  end

  test do
    system "Rscript", "-e", 'if (!library(poolSeq,logical.return=TRUE)) q("no",11,FALSE)'
  end
end

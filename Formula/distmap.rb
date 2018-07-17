class Distmap < Formula
  desc "Wrapper around various mappers for distributed computation with Hadoop"
  homepage "https://sourceforge.net/projects/distmap/"
  head "https://github.com/robmaz/distmap.git"

  def install
    bin.install Dir["bin/*"]
    perl5lib = lib/"perl5/site_perl"
    perl5lib.install Dir["lib/perl5/site_perl/*.pm"]
    javalib = share/"java"
    javalib.install "share/java/distmap"
    #libexec.install "libexec/linux"
    #libexec.install "libexec/macos"
  end

  test do
    system "#{bin}/distmap", "--help"
  end
end

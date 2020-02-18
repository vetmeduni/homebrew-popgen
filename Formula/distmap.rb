class Distmap < Formula
  desc "Wrapper around various mappers for distributed computation with Hadoop"
  homepage "https://sourceforge.net/projects/distmap/"
  url "https://github.com/robmaz/distmap/archive/v.3.1.0.tar.gz"
  sha256 "eb777705825f615712c587649a365e58d19b09dc589552bee34eb8ae6d49b20e"
  head "https://github.com/robmaz/distmap.git"

  def install
    bin.install Dir["bin/*"]
    perl5lib = lib/"perl5/site_perl"
    perl5lib.install Dir["lib/perl5/site_perl/*.pm"]
  end

  test do
    system "#{bin}/distmap", "--help"
  end
end

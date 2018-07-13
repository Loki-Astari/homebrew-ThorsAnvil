class ThorsSerializer < Formula
  desc "Declarative Serialization Library for C++. Serializes in Json/Yaml"
  homepage "https://github.com/Loki-Astari/ThorsSerializer"
  url "https://github.com/Loki-Astari/ThorsSerializer/raw/ThorsSerializer-1.0.0.tar.gz"

  def install
    system "./configure", "--disable-binary", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end

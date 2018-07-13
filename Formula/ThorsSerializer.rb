class Thorsserializer < Formula
  desc "Declarative Serialization Library for C++. Serializes in Json/Yaml"
  homepage "https://github.com/Loki-Astari/ThorsSerializer"
  url "git@github.com:Loki-Astari/ThorsSerializer.git", :using => :git, :tag => "1.5.1"

  ENV["COV"]  = "gcov"

  def install
    system "./configure", "--disable-binary", "--prefix=#{prefix}"
    system "make", "install"
  end

  depends_on "wget"
  depends_on "cmake"

  test do
    system "false"
  end
end

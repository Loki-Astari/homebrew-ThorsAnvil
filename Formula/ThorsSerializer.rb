class GitWithGitAt < GitHubGitDownloadStrategy
  def update_submodules
    if ! File.exist?(".firstTime")
        system "mv", ".gitmodules", "gitmodules.old"
        system("sed -e 's#git@\\([^:]*\\):#https://\\1/#' gitmodules.old > .gitmodules")
        File.open(".firstTime", "w") {}
    else
        super
    end
  end
end

class Thorsserializer < Formula
  desc "Declarative Serialization Library for C++. Serializes in Json/Yaml"
  homepage "https://github.com/Loki-Astari/ThorsSerializer"
  url "git@github.com:Loki-Astari/ThorsSerializer.git", :using => GitWithGitAt, :tag => "1.5.2"

  ENV["COV"]  = "gcov"

  def install
    system "./configure", "--disable-binary", "--disable-vera", "--prefix=#{prefix}"
    system "make", "install"
  end

  depends_on "wget"
  depends_on "cmake"

  test do
    system "false"
  end
end

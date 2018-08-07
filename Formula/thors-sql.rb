class ThorsSql < Formula
  desc "SQL library for C++14"
  homepage "https://github.com/Loki-Astari/ThorsSQL"
  url "https://github.com/Loki-Astari/ThorsSQL.git",
      :tag => "1.5.0",
      :revision => "ed6c835aed56f90f7aa2f7e5f5872b918b566402"

  depends_on "mysql" => :build

  needs :cxx14

  def install
    ENV["COV"] = "gcov"
    system "cat", "src/MySQL/test/data/init.sql", "|", "mysql", "-f", "-u", "root"
    system "./configure", "--disable-vera",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "ThorSQL/Connection.h"
      #include "ThorSQL/Statement.h"

      int main()
      {
          namespace SQL = ThorsAnvil::SQL;

          std::map<std::string, std::string>      options {{"default-auth", "mysql_native_password"}};
          SQL::Connection   connection("mysql://localhost", "test", "testPassword", "test", options);
          SQL::Statement    statement(connection, "SELECT Age FROM People");

          int sumAge = 0;
          int count  = 0;
          statement.execute([&sumAge, &count](int age) {
            sumAge  += age;
            ++count;
          });

          if (count != 2 || sumAge != 61) {
            std::cerr << "Fail\n";
            return 1;
          }
          std::cerr << "OK\n";
          return 0;
      }
    EOS
    system ENV.cxx, "-std=c++14", "test.cpp", "-o", "test",
           "-I#{include}", "-L#{lib}", "-lThorMySQL17", "-lThorSQL17"
    system "./test"
  end
end

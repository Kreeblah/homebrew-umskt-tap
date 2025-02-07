class Umskt < Formula
  desc "Windows and Office Activation Code Generator"
  homepage "https://github.com/UMSKT/UMSKT"
  url "https://github.com/UMSKT/UMSKT.git",
      tag:      "v0.2.0-beta",
      revision: "27344f6d4b37316439cacc5eb496b3fbc6224f2d"
  license "GPL-3.0-only"
  head "https://github.com/UMSKT/UMSKT.git", branch: "master"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/umskt"
    lib.install "build/lib_umskt.dylib"
    system "cp", "build/_deps/fmt-build/libfmt.10.0.0.dylib", "#{prefix}"
  end

  def post_install
    system "mv", "#{prefix}/libfmt.10.0.0.dylib", "#{lib}/libfmt.10.0.0.dylib"
    system "ln", "-s", "#{lib}/libfmt.10.0.0.dylib", "#{lib}/libfmt.10.dylib"
    system "ln", "-s", "#{lib}/libfmt.10.dylib", "#{lib}/libfmt.dylib"
    system "install_name_tool", "-change", "@rpath/libfmt.10.dylib", "#{lib}/libfmt.10.dylib", "#{lib}/lib_umskt.dylib"
    system "install_name_tool", "-change", "@rpath/lib_umskt.dylib", "#{lib}/lib_umskt.dylib", "#{bin}/umskt"
    system "install_name_tool", "-change", "@rpath/libfmt.10.dylib", "#{lib}/libfmt.10.dylib", "#{bin}/umskt"
    system "codesign", "--force", "--deep", "--preserve-metadata=entitlements,requirements,flags,runtime", "--sign", "-", "#{lib}/lib_umskt.dylib"
    system "codesign", "--force", "--deep", "--preserve-metadata=entitlements,requirements,flags,runtime", "--sign", "-", "#{bin}/umskt"
  end
end

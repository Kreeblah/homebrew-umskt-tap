class Umskt < Formula
  desc "Windows and Office Activation Code Generator"
  homepage "https://github.com/UMSKT/UMSKT"
  url "https://github.com/UMSKT/UMSKT/archive/refs/tags/v0.3.2-beta.tar.gz"
  sha256 "9697861827c8874a40af6ec11aa32fffb7cfe0180117479f642f153b48fb4f0c"
  license "GPL-3.0-only"
  head "https://github.com/UMSKT/UMSKT.git", branch: "master"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/umskt"
  end
end

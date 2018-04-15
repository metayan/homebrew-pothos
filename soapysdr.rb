class Soapysdr < Formula
  desc "Vendor and platform neutral SDR support library"
  homepage "https://github.com/pothosware/SoapySDR/wiki"
  head "https://github.com/pothosware/SoapySDR.git"
  url "https://github.com/pothosware/SoapySDR/archive/soapy-sdr-0.6.1.tar.gz"
  sha256 "2ecf8e43518dfb24bd172923adf6ce25a6d3e39de3a8aadf26c890f60dd1e9f7"

  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "python2" => :optional
  depends_on "python3" => :recommended

  def install

    args = []

    if build.with?("python")
        args += ["-DENABLE_PYTHON=ON"]
        args += ["-DUSE_PYTHON_CONFIG=ON"]
    else
        args += ["-DENABLE_PYTHON=OFF"]
    end

    if build.with?("python3")
      args += ["-DENABLE_PYTHON3=ON"]
    else
      args += ["-DENABLE_PYTHON3=OFF"]
    end

    if !(build.head?)
      args += ["-DSOAPY_SDR_EXTVER=release"]
    end

    args += %W[-DSOAPY_SDR_ROOT='#{HOMEBREW_PREFIX}']

    mkdir "build" do
      args += std_cmake_args
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end

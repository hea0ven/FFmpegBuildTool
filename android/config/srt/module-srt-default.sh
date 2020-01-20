#!/usr/bin/env bash
###
##--cygwin-use-posix - Should the POSIX API be used for cygwin. Ignored if the system isn't cygwin. (default: OFF)
## --enable-apps - Should the Support Applications be Built? (default: ON)
## --enable-c++-deps - Extra library dependencies in srt.pc for C language (default: OFF)
## --enable-c++11 - Should the c++11 parts (srt-live-transmit) be enabled (default: ON)
## --enable-code-coverage - Enable code coverage reporting (default: OFF)
## --enable-debug=<0,1,2> - Enable debug mode (0=disabled, 1=debug, 2=rel-with-debug)
###        --enable-encryption - Should encryption features be enabled (default: ON)
  ##      --enable-getnameinfo - In-logs sockaddr-to-string should do rev-dns (default: OFF)
    ##    --enable-haicrypt-logging - Should logging in haicrypt be enabled (default: OFF)
##        --enable-heavy-logging - Should heavy debug logging be enabled (default: OFF)
  ##      --enable-inet-pton - Set to OFF to prevent usage of inet_pton when building against modern SDKs (default: ON)
    ##    --enable-logging - Should logging be enabled (default: ON)
      ##  --enable-monotonic-clock - Enforced clock_gettime with monotonic clock on GC CV /temporary fix for #729/ (default: OFF)
##  --enable-profile - Should instrument the code for profiling. Ignored for non-GNU compiler. (default: OFF)
##        --enable-relative-libpath - Should applications contain relative library paths, like ../lib (default: OFF)
##        --enable-shared - Should libsrt be built as a shared library (default: ON)
#        --enable-static - Should libsrt be built as a static library (default: ON)
#        --enable-suflip - Should suflip tool be built (default: OFF)
#        --enable-testing - Should developer testing applications be built (default: OFF)
#        --enable-thread-check - Enable #include <threadcheck.h> that implements THREAD_* macros
#        --enable-unittests - Enable unit tests (default: OFF)
#        --openssl-crypto-library=<filepath> - Path to a library.
#        --openssl-include-dir=<path> - Path to a file.
#        --openssl-ssl-library=<filepath> - Path to a library.
#        --pkg-config-executable=<filepath> - pkg-config executable
#        --pthread-include-dir=<path> - Path to a file.
#        --pthread-library=<filepath> - Path to a library.
#        --use-busy-waiting - Enable more accurate sending times at a cost of potentially higher CPU load (default: OFF)
#        --use-enclib - Encryption library to be used: openssl(default), gnutls, mbedtls
#        --use-gnustl - Get c++ library/headers from the gnustl.pc
#        --use-gnutls - DEPRECATED. Use USE_ENCLIB=openssl|gnutls|mbedtls instead
#        --use-openssl-pc - Use pkg-config to find OpenSSL libraries (default: ON)
#        --use-static-libstdc++ - Should use static rather than shared libstdc++ (default: OFF)
#        --with-compiler-prefix=<prefix> - set C/C++ toolchains <prefix>gcc and <prefix>g++
#        --with-compiler-type=<name> - compiler type: gcc(default), cc, others simply add ++ for C++
#        --with-haicrypt-name=<name> - Override haicrypt library name (if compiled separately)
#        --with-srt-name=<name> - Override srt library name
#NOTE1: Option list may be incomplete. Refer to variables in CMakeLists.txt
#NOTE2: Non-internal options turn e.g. --enable-c++11 into cmake -DENABLE_CXX11=1
#NOTE3: You can use --disable-x instead of --enable-x=0 for the above options.
###
export COMMON_SRT_CFG_FLAGS=

export COMMON_SRT_CFG_FLAGS="$COMMON_SRT_CFG_FLAGS --enable-static"
export COMMON_SRT_CFG_FLAGS="$COMMON_SRT_CFG_FLAGS --use-openssl-pc"

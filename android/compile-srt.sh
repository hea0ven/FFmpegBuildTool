#!/usr/bin/env bash

source ../tools/colors.sh #!/bin/sh
source ../tools/common.sh #!/bin/sh

set -e

function make_android_srt_config_params() {

    echo "--------------------"
    echo -e "${red}[*] make config params ${nc}"
    echo "--------------------"

    android_standalone_toolchain_clang=clang3.6

    # cfg_flags="$cfg_flags zlib-dynamic"
    # cfg_flags="$cfg_flags no-shared"
    # cfg_flags="$cfg_flags -fPIE -fPIC"
    # ld_flags="$ld_flags -pie"

    if [[ "$target_arch" = "armv7a" ]]; then

        android_platform_name=21

        android_platform_arch_name="armeabi-v7a"

        android_standalone_toolchain_cross_prefix_name=arm-linux-androideabi

        android_standalone_toolchain_name=arm-linux-android-${android_standalone_toolchain_clang}

        # cfg_flags="$cfg_flags android-arm"

    elif [[ "$target_arch" = "armv8a" ]]; then

        android_platform_name=21

        android_platform_arch_name="arm64-v8a"

        android_standalone_toolchain_cross_prefix_name=aarch64-linux-android

        android_standalone_toolchain_name=aarch64-linux-android-${android_standalone_toolchain_clang}

        # cfg_flags="$cfg_flags android-arm64"

    elif [[ "$target_arch" = "x86" ]]; then

        android_platform_name=21

        android_platform_arch_name="x86"

        android_standalone_toolchain_cross_prefix_name=i686-linux-android

        android_standalone_toolchain_name=x86-linux-android-${android_standalone_toolchain_clang}

        # cfg_flags="$cfg_flags android-x86 no-asm"

    elif [[ "$target_arch" = "x86_64" ]]; then

        android_platform_name=21

        android_platform_arch_name="x86_64"

        android_standalone_toolchain_cross_prefix_name=x86_64-linux-android

        android_standalone_toolchain_name=x86_64-linux-android-${android_standalone_toolchain_clang}

        # cfg_flags="$cfg_flags android-x86_64"

     case "$ndk_rel" in
        18*|19*)
            android_platform_name=23
        ;;
        13*|14*|15*|16*|17*)
            android_platform_name=21
        ;;
    esac

    else
        echo "unknown architecture $target_arch";
        exit 1
    fi


    export PATH=${toolchain_path}/bin:$PATH
    export RANLIB=${toolchain_path}/bin/${android_standalone_toolchain_cross_prefix_name}-ranlib
    export CFLAGS="-fPIE -fPIC"
    export LDFLAGS="-pie"

    if [[ -f "${output_path_depend}/lib/libssl.a" ]]; then
      echo "find openssl"
      echo ""
      cfg_flags="$cfg_flags --use-openssl-pc=OFF"
      cfg_flags="$cfg_flags --openssl-ssl-library=${output_path_depend}/lib/libssl.a"
      cfg_flags="$cfg_flags --openssl-crypto-library=${output_path_depend}/lib/libcrypto.a"
      cfg_flags="$cfg_flags --openssl-include-dir=${output_path_depend}/include/"
    fi


    cfg_flags="$cfg_flags --prefix=$output_path"
    cfg_flags="$cfg_flags --cmake_install_prefix=${output_path}"
    cfg_flags="$cfg_flags --enable-static"
    cfg_flags="$cfg_flags --disable-shared"
    # cfg_flags="$cfg_flags --with-target-path=${toolchain_path}"
    cfg_flags="$cfg_flags --cmake_system_name=Android"
    cfg_flags="$cfg_flags --CMAKE_C_COMPILER_RANLIB"
    cfg_flags="$cfg_flags --CMAKE_C_COMPILER_RANLIB=${RANLIB}"
    cfg_flags="$cfg_flags --CMAKE_CXX_COMPILER_RANLIB=${RANLIB}"
    cfg_flags="$cfg_flags --CMAKE_RANLIB=${RANLIB}"
    cfg_flags="$cfg_flags --cmake_android_api=${android_platform_name}"
    cfg_flags="$cfg_flags --cmake_android_arch_abi=${android_platform_arch_name}"

    echo "ranlib = $ranlib"
    echo "cfg_flags = $cfg_flags"
    echo ""
    echo "ld_flags = $ld_flags"
    echo ""
    echo "dep_libs = $ld_libs"
    echo ""
    echo "android_platform_name = $android_platform_name"
    echo ""
    echo "android_standalone_toolchain_name = $android_standalone_toolchain_name"
    echo ""
}

function compile() {
    check_env
    check_ndk
    make_env_params
    make_android_srt_config_params
    make_android_toolchain
    make_android_srt_product
}

#构建Android SRT产物
function make_android_srt_product(){
  echo "--------------------"
  echo -e "${red}[*] compile android srt ${nc}"
  echo "--------------------"

  current_path=$(pwd)

  cd ${source_path}

  echo "current directory = ${source_path}"

  mkdir -p ${source_path}/build

  cd build

  ../configure ${cfg_flags}
  make
  make install

  cp -r ${output_path}/include ${product_path}/include
  mkdir -p ${product_path}/lib
  cp ${output_path}/lib/libsrt.a ${product_path}/lib/libsrt.a

  cd ${current_path}

  echo "product_path = ${product_path}"
  echo ""
  echo "product_path_include = ${product_path}/include"
  echo ""
  echo "product_path_lib = ${product_path}/lib"
  echo ""
  echo "finish srt successfully"
}

target_arch=$1
arch_all="armv7a armv8a x86 x86_64"
name_depend=openssl
name=srt
android_platform_arch_name=

function main() {
    case "$target_arch" in
        all)
            for arch in ${arch_all}
            do
                reset
                target_arch=${arch}
                echo_arch
                compile
            done
        ;;
        armv7a|armv8a|x86|x86_64)
            echo_arch
            compile
        ;;
        clean)
            for arch in ${arch_all};
            do
                if [[ -d ${name}-${arch} ]]; then
                    echo "${name}-${arch}"
                    cd ${name}-${arch} && git clean -xdf && cd -
                fi
                rm -rf ./build/output/${name}-${arch}
                rm -rf ./build/product/${name}-${arch}
                rm -rf ./build/toolchain/${name}-${arch}
                rm -rf ./build/src/${name}-${arch}/build
                echo "clean ${name}-${arch} successfully"
                echo ""
            done
        ;;
        check)
            echo_arch
        ;;
        *)
            echo_compile_usage
            exit 1
        ;;
    esac
}

main

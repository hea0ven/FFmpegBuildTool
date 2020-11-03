#! /usr/bin/env bash

source ../tools/colors.sh
source ../tools/common.sh
set -e

function make_android_librtmp_config_params() {

    echo "--------------------"
    echo -e "${red}[*] make config params ${nc}"
    echo "--------------------"

    android_standalone_toolchain_clang=clang


    if [[ "$target_arch" = "armv7a" ]]; then

        android_platform_name=android-21


        android_standalone_toolchain_name=arm-linux-androideabi-${android_standalone_toolchain_clang}

        android_standalone_toolchain_cross_prefix_name=arm-linux-androideabi-

        # cfg_flags="$cfg_flags android-arm"

    elif [[ "$target_arch" = "armv8a" ]]; then

        android_platform_name=android-21

        android_standalone_toolchain_name=aarch64-linux-android-${android_standalone_toolchain_clang}

        android_standalone_toolchain_cross_prefix_name=aarch64-linux-android-


        # cfg_flags="$cfg_flags android-arm64"

    elif [[ "$target_arch" = "x86" ]]; then

        android_platform_name=android-21

        android_standalone_toolchain_name=x86-linux-android-${android_standalone_toolchain_clang}

        android_standalone_toolchain_cross_prefix_name=i686-linux-android-


        # cfg_flags="$cfg_flags android-x86 no-asm"

    elif [[ "$target_arch" = "x86_64" ]]; then

        android_platform_name=android-21

        android_standalone_toolchain_name=x86_64-linux-android-${android_standalone_toolchain_clang}

        android_standalone_toolchain_cross_prefix_name=x86_64-linux-android-


        # cfg_flags="$cfg_flags android-x86_64"

     case "$ndk_rel" in
        18*|19*|20*)
            android_platform_name=android-23
        ;;
        13*|14*|15*|16*|17*)
            android_platform_name=android-21
        ;;
    esac

    else
        echo "unknown architecture $target_arch";
        exit 1
    fi

    cfg_flags="$cfg_flags prefix=$output_path"
    cfg_flags="$cfg_flags CROSS_COMPILE=${android_standalone_toolchain_cross_prefix_name}"
    cfg_flags="$cfg_flags CC=${android_standalone_toolchain_cross_prefix_name}${android_standalone_toolchain_clang}"
    cfg_flags="$cfg_flags CRYPTO= "
    cfg_flags="$cfg_flags SHARED= "

    echo "cfg_flags = $cfg_flags"
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
    make_android_librtmp_config_params
    make_android_toolchain
    make_android_librtmp_product
}

target_arch=$1
arch_all="armv7a armv8a x86 x86_64"
build_root=$(pwd)/build
name=librtmp

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
            for arch in ${arch_all}; do
                if [[ -d ${name}-${arch} ]]; then
                    cd ${name}-${arch} && git clean -xdf && cd -
                fi
                rm -rf ./build/output/${name}-${arch}/**
                rm -rf ./build/product/${name}-${arch}/**
                rm -rf ./build/toolchain/${name}-${arch}/**
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

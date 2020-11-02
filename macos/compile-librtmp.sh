#! /usr/bin/env bash

source ../tools/colors.sh
source ../tools/common.sh
set -e

function make_mac_rtmp_config_params() {

    echo "--------------------"
    echo -e "${red}[*] make config params ${nc}"
    echo "--------------------"

    cfg_flags="$cfg_flags prefix=$output_path"

    cfg_flags="$cfg_flags CRYPTO="

    cfg_flags="$cfg_flags SYS=darwin"

    xcrun_platform_name="MacOSX"

    xcrun_osversion="-mmacosx-version-min=10.10"

    cfg_cpu="$cfg_cpu"

    echo "cfg_flags = $cfg_flags"
    echo ""
    echo "dep_libs = $ld_libs"
    echo ""
    echo "ld_flags = $ld_flags"
    echo ""
    echo "cfg_cpu = $cfg_cpu"
    echo ""
    echo "xcrun_platform_name = $xcrun_platform_name"
    echo ""
    echo "xcrun_osversion = $xcrun_osversion"
    echo ""
}




function compile() {
    check_env
    check_ios_mac_host
    make_env_params
    make_mac_rtmp_config_params
    make_ios_or_mac_toolchain
    make_ios_or_mac_rtmp_product
}

target_arch=$1
arch_all="x86_64"
name=rtmpdump
build_root=$(pwd)/build

function main() {
    current_path=`pwd`
    case "$target_arch" in
        armv7|armv7s|arm64|i386|x86_64)
            echo_arch
            compile
        ;;
        clean)
            for arch in ${arch_all}
            do
                if [[ -d ${name}-${arch} ]]; then
                    cd ${name}-${arch} && git clean -xdf && cd -
                fi
            done
            rm -rf ./build/output/**
            rm -rf ./build/product/**
            rm -rf ./build/toolchain/**
            echo "clean complete"
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
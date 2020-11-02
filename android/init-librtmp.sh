#!/usr/bin/env bash


source ../tools/colors.sh #!/bin/sh
source ../tools/common.sh #!/bin/sh

set -e

# 目标架构
target_arch=$1

# 库名称
name=librtmp

# 库地址
upstream=git://git.ffmpeg.org/rtmpdump

# 库分支
branch=master

# 本地库地址
local_repo=../repository/librtmp

# 所有架构
arch_all="armv7a armv8a x86 x86_64"

init_repository

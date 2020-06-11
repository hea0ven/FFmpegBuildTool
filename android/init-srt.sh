#!/usr/bin/env bash


source ../tools/colors.sh #!/bin/sh
source ../tools/common.sh #!/bin/sh

set -e

# 目标架构
target_arch=$1

# 库名称
name=srt

# 库地址
upstream=https://github.com/Haivision/srt

# 库分支
branch=master

# 本地库地址
local_repo=../repository/srt

# 所有架构
arch_all="armv7a armv8a x86 x86_64"

init_repository

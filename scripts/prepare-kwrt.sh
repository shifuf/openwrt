#!/bin/bash

set -euo pipefail

OPENWRT_DIR=${1:-openwrt}
KWRT_DIR=${2:-kwrt}
CONFIG_FILE=${3:-config/qualcommax_ipq60xx.config}
DEVICE_ID=${DEVICE_ID:-qualcommax_ipq60xx}
PASSWALL_BRANCH=${PASSWALL_BRANCH:-main}
ROOT_DIR=$(pwd)

to_abs_path() {
    case "$1" in
        /*) printf '%s\n' "$1" ;;
        *) printf '%s/%s\n' "$ROOT_DIR" "$1" ;;
    esac
}

git_clone_path() {
    local repo_url=$1
    local branch=$2
    local target_path=$3

    rm -rf "$target_path"
    git clone --depth 1 -b "$branch" "$repo_url" "$target_path"
    rm -rf "$target_path/.git"
}

apply_patch_dir() {
    local patch_dir=$1
    local patch_file

    if [ ! -d "$patch_dir" ]; then
        return 0
    fi

    shopt -s nullglob
    for patch_file in "$patch_dir"/*.patch; do
        echo "Applying patch: $(basename "$patch_file")"
        patch -f -p1 < "$patch_file"
    done
    shopt -u nullglob
}

OPENWRT_DIR=$(to_abs_path "$OPENWRT_DIR")
KWRT_DIR=$(to_abs_path "$KWRT_DIR")
CONFIG_FILE=$(to_abs_path "$CONFIG_FILE")

if [ ! -d "$OPENWRT_DIR" ]; then
    echo "OpenWrt directory not found: $OPENWRT_DIR" >&2
    exit 1
fi

if [ ! -d "$KWRT_DIR" ]; then
    echo "Kwrt directory not found: $KWRT_DIR" >&2
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file not found: $CONFIG_FILE" >&2
    exit 1
fi

if [ ! -d "$KWRT_DIR/devices/$DEVICE_ID" ]; then
    echo "Kwrt device directory not found: $KWRT_DIR/devices/$DEVICE_ID" >&2
    exit 1
fi

echo "Preparing Kwrt device stack from: $KWRT_DIR"

mkdir -p "$OPENWRT_DIR/devices"
rm -rf "$OPENWRT_DIR/devices/common" "$OPENWRT_DIR/devices/$DEVICE_ID"
cp -R "$KWRT_DIR/devices/common" "$OPENWRT_DIR/devices/"
mkdir -p "$OPENWRT_DIR/devices/$DEVICE_ID"
cp -R "$KWRT_DIR/devices/$DEVICE_ID/." "$OPENWRT_DIR/devices/$DEVICE_ID/"

if [ -d "$OPENWRT_DIR/devices/$DEVICE_ID/patches" ]; then
    mkdir -p "$OPENWRT_DIR/devices/common/patches"
    cp -R "$OPENWRT_DIR/devices/$DEVICE_ID/patches/." "$OPENWRT_DIR/devices/common/patches/"
fi

export -f git_clone_path
export REPO_TOKEN="${REPO_TOKEN:-}"

pushd "$OPENWRT_DIR" >/dev/null

chmod +x "devices/common/diy.sh" "devices/$DEVICE_ID/diy.sh"

echo "Running Kwrt common diy"
bash "devices/common/diy.sh"

echo "Running Kwrt device diy for $DEVICE_ID"
bash "devices/$DEVICE_ID/diy.sh"

apply_patch_dir "devices/common/patches"

sed -i '/^src-git passwall /d;/^src-git passwall-packages /d;/^# PassWall feeds added by local workflow$/d' feeds.conf.default
printf '\n# PassWall feeds added by local workflow\n' >> feeds.conf.default
echo "src-git passwall https://github.com/Openwrt-Passwall/openwrt-passwall.git;${PASSWALL_BRANCH}" >> feeds.conf.default
echo "src-git passwall-packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;${PASSWALL_BRANCH}" >> feeds.conf.default

echo "Updating PassWall feeds"
./scripts/feeds update passwall passwall-packages

echo "Installing PassWall feeds"
./scripts/feeds install -a -p passwall
./scripts/feeds install -a -p passwall-packages

cp "$CONFIG_FILE" .config

popd >/dev/null

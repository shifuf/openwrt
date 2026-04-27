#!/bin/bash

set -euo pipefail

OPENWRT_DIR=${1:-openwrt}
KWRT_DIR=${2:-kwrt}
CONFIG_FILE=${3:-config/qualcommax_ipq60xx.config}
DEVICE_ID=${DEVICE_ID:-qualcommax_ipq60xx}
PASSWALL_BRANCH=${PASSWALL_BRANCH:-main}
DEFAULT_LAN_IP=${DEFAULT_LAN_IP:-192.168.1.1}
ROOT_DIR=$(pwd)

to_abs_path() {
    case "$1" in
        /*) printf '%s\n' "$1" ;;
        *) printf '%s/%s\n' "$ROOT_DIR" "$1" ;;
    esac
}

git_clone_path() {
    local branch=$1
    local repo_url=$2
    local move_mode=${3:-}
    local rootdir=$PWD
    local tmpdir=""

    trap 'rm -rf "${tmpdir:-}"' EXIT

    if [ "$move_mode" != "mv" ]; then
        shift 2
    else
        shift 3
    fi

    tmpdir=$(mktemp -d) || exit 1

    if [ ${#branch} -lt 10 ]; then
        git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$repo_url" "$tmpdir"
        cd "$tmpdir"
    else
        git clone --filter=blob:none --sparse "$repo_url" "$tmpdir"
        cd "$tmpdir"
        git checkout "$branch"
    fi

    if [ "$?" != 0 ]; then
        echo "error on $repo_url"
        exit 1
    fi

    git sparse-checkout init --cone
    git sparse-checkout set "$@"

    if [ "$move_mode" != "mv" ]; then
        cp -rn ./* "$rootdir"/
    else
        mv -n $@/* $rootdir/$@/
    fi

    cd "$rootdir"
    rm -rf "$tmpdir"
    trap - EXIT
}

apply_kwrt_patches() {
    local patch_root="devices/$DEVICE_ID/patches"
    local patch_file

    if [ -d "devices/common/patches" ]; then
        mkdir -p "$patch_root"
        cp -rn devices/common/patches/. "$patch_root/" 2>/dev/null || true
    fi

    if [ ! -d "$patch_root" ]; then
        return 0
    fi

    shopt -s nullglob

    for patch_file in "$patch_root"/*.bin.patch; do
        echo "Applying binary patch: $(basename "$patch_file")"
        git apply "$patch_file"
    done

    for patch_file in "$patch_root"/*.revert.patch; do
        echo "Reverting patch: $(basename "$patch_file")"
        patch -d "./" -R --no-backup-if-mismatch -p1 -F 1 --ignore-whitespace -i "$patch_file"
    done

    for patch_file in "$patch_root"/*.patch; do
        case "$patch_file" in
            *.bin.patch|*.revert.patch)
                continue
                ;;
        esac
        echo "Applying patch: $(basename "$patch_file")"
        patch -d "./" --no-backup-if-mismatch -p1 -F 1 --ignore-whitespace -i "$patch_file"
    done

    shopt -u nullglob
}

force_default_lan_ip() {
    local lan_subnet=${DEFAULT_LAN_IP%.*}

    if [ -f package/base-files/files/bin/config_generate ]; then
        sed -i \
            -e "s/10\\.0\\.0\\.1/${DEFAULT_LAN_IP}/g" \
            -e "s/10\\.0\\.0\\./${lan_subnet}./g" \
            package/base-files/files/bin/config_generate
    fi

    find package feeds -path '*my-default-settings*' -type f 2>/dev/null | while read -r file; do
        sed -i \
            -e "s/10\\.0\\.0\\.1/${DEFAULT_LAN_IP}/g" \
            -e "s/10\\.0\\.0\\./${lan_subnet}./g" \
            "$file" || true
    done
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

mkdir -p "$OPENWRT_DIR"
rm -rf "$OPENWRT_DIR/devices"
cp -R "$KWRT_DIR/devices" "$OPENWRT_DIR/"
cp -R "$KWRT_DIR/devices/common/." "$OPENWRT_DIR/"
cp -R "$KWRT_DIR/devices/$DEVICE_ID/." "$OPENWRT_DIR/"

export -f git_clone_path
export REPO_TOKEN="${REPO_TOKEN:-}"

pushd "$OPENWRT_DIR" >/dev/null

chmod +x "devices/common/diy.sh"

echo "Running Kwrt common diy"
bash "devices/common/diy.sh"

if [ -f "devices/common/.config" ]; then
    cp -f "devices/common/.config" .config
else
    : > .config
fi

if [ -f "devices/$DEVICE_ID/.config" ]; then
    echo >> .config
    cat "devices/$DEVICE_ID/.config" >> .config
fi

echo >> .config
cat "$CONFIG_FILE" >> .config

if [ -f "devices/$DEVICE_ID/diy.sh" ]; then
    chmod +x "devices/$DEVICE_ID/diy.sh"
    echo "Running Kwrt device diy for $DEVICE_ID"
    bash "devices/$DEVICE_ID/diy.sh"
fi

cp -Rf ./diy/* ./ 2>/dev/null || true

apply_kwrt_patches

sed -i '/^src-git passwall /d;/^src-git passwall-packages /d;/^# PassWall feeds added by local workflow$/d' feeds.conf.default
printf '\n# PassWall feeds added by local workflow\n' >> feeds.conf.default
echo "src-git passwall https://github.com/Openwrt-Passwall/openwrt-passwall.git;${PASSWALL_BRANCH}" >> feeds.conf.default
echo "src-git passwall-packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;${PASSWALL_BRANCH}" >> feeds.conf.default

echo "Updating PassWall feeds"
./scripts/feeds update passwall passwall-packages

echo "Installing PassWall feeds"
./scripts/feeds install -a -p passwall
./scripts/feeds install -a -p passwall-packages

echo "Forcing default LAN IP to ${DEFAULT_LAN_IP}"
force_default_lan_ip

popd >/dev/null

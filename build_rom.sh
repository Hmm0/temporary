
# sync rom
repo init --depth=1 -u https://github.com/Havoc-OS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/P-Salik/local_manifest --depth=1 -b HavocOS .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Patches
cd external/selinux
curl -LO https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
patch -p1 < *.patch
cd ../..

#cd frameworks/av
#curl -LO https://github.com/phhusson/platform_frameworks_av/commit/624cfc90b8bedb024f289772960f3cd7072fa940.patch
#patch -p1 < *.patch
#cd ../../

#cd frameworks/base
#curl -LO https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch
#patch -p1 < *.patch
#cd ../..

#cd frameworks/opt/net/wifi
#curl -LO https://github.com/PixelExperience/frameworks_opt_net_wifi/commit/3bd2c14fbda9c079a4dc39ff4601ba54da589609.patch
#patch -p1 < *.patch
#cd ../../../..

# build
. build/envsetup.sh
export HAVOC_MAINTAINER=P_Salik16
lunch havoc_RMX1941-userdebug
brunch RMX1941 \
	&& repo forall -c 'git checkout .' || repo forall -c 'git checkout .'

# upload build
# If you need to upload json/multiple files too then put like this
#rclone copy out/target/product/RMX1941/*.zip cirrus:mido -P
#rclone copy out/target/product/RMX1941/*.zip.json cirrus:mido -P'
rclone copy out/target/product/RMX1941/*Unofficial*.zip cirrus:RMX1941 -P

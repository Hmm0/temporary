# sync rom
repo init -u https://github.com/ZenX-OS/android_manifest.git -b 11.1 --depth=1 --no-repo-verify -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/cArN4gEisDeD/local_manifest --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch zeus_RMX1941-userdebug
brunch RMX1941


# upload
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P

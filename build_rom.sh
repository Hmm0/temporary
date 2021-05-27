# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ArrowOS/android_manifest.git -b arrow-11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ECr34T1v3/android_.repo_local_manifests.git --depth 1 -b beyond0-arrow .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch arrow_beyond0lte-userdebug
m bacon

# upload rom
rclone copy out/target/product/beyond0lte/*.zip cirrus:beyond0lte -P

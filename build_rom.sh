# sync rom
repo init -u https://github.com/Spark-Rom/manifest -b fire --depth=1 --no-repo-verify -g default,-device,-mips,-darwin,-notdefault
ggit clone https://github.com/cArN4gEisDeD/local_manifest --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/env*
export WITH_GAPPS=true
lunch spark_RMX1941-userdebug
mka spark


# upload
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P

#!/usr/bin/env bash

cd build || exit

# get huskydg'ss module template
echo "Downloading huskydg module template..."

curl -sSLO https://github.com/NoName-exe/huskydg-module-template/releases/download/latest/revanced-magisk.zip

echo "Download finished"

# unzip that module 
echo "Unzipping the downloaded zip"

unzip revanced-magisk.zip -d huskydg

echo "Finished unzipping the downloaded zip"

#remove the downloaded zip as it is no longer useful
echo "Removing the downloaded zip..."

rm -rf revanced-magisk.zip

echo "Downloaded zip removed"

# find the name of the built zip as it will be very useful later
echo "Finding out the name of the built module zip..."

ghrelname="$(find . -maxdepth 1 -name "youtube-revanced-*.zip" -printf '%P')"

echo "The built module is named $ghrelname "

#unzip the built zip so we can repack it into a different module template
echo "Unzipping the built module..."

unzip "$ghrelname" -d jhc

echo "Finished unzipping the built module "

#remove the built module zip as it is no longer needed
echo "Removing built zip..."

rm -rf "$ghrelname"

echo "Removed $ghrelname "

#start the repacking process
echo "Starting the repacking process..."

mv jhc/module.prop huskydg/module.prop

mv jhc/base.apk jhc/revanced.apk

mv jhc/revanced.apk huskydg/revanced.apk

mv jhc/com.google.android.youtube.apk jhc/base.apk

mv jhc/base.apk huskydg/system/priv-app/youtube/base.apk

rm -rf jhc/

cd huskydg/ || exit

zip -r9 "$ghrelname" "$(ls)" .

mv "$ghrelname" ../

cd ../

rm -rf huskydg/

#the repacking process is now over
echo "Finished repacking."

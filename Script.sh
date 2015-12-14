#!/bin/sh

CONFIG_ROOT_PATH="/Users/kuailefu/Desktop/ipa/"

cd $CONFIG_ROOT_PATH
 
sourceipaname="TouchID.ipa"
appname="TouchID.app"  #加压后Pauload目录项.app文件名需要根据自己的项目修改
distDir="/Users/kuailefu/Desktop/ipa/OK"   #打包后文件存储目录
rm -rdf "$distDir "   
mkdir "$distDir"
unzip $sourceipaname     #解压母包文件
 
kChannelNumber=("1" "2" "3")
for i in ${kChannelNumber[@]};
do
cd Payload
cd $appname
 
    ipafilename=${kChannelNumber[$i]}
    targetName="TouchIDOK"
    /usr/libexec/PlistBuddy -c "set :CFBundleDisplayName $i" Info.plist
 
    cd ../..
    zip -r "${targetName}_${ipafilename}.ipa" Payload   #打成其他渠道的包
    mv "${targetName}_${ipafilename}.ipa" $distDir
done
rm -rdf Payload
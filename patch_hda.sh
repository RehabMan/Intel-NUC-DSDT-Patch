#!/bin/bash

#set -x

unpatched=/System/Library/Extensions
#unpatched=~/Desktop

# extract minor version (eg. 10.9 vs. 10.10 vs. 10.11)
MINOR_VER=$([[ "$(sw_vers -productVersion)" =~ [0-9]+\.([0-9]+) ]] && echo ${BASH_REMATCH[1]})

# AppleHDA patching function
function createAppleHDAInjector()
{
# create AppleHDA injector for Clover setup...
    echo -n "Creating AppleHDA_$1.kext..."
    rm -Rf AppleHDA_$1.kext
    mkdir AppleHDA_$1.kext
    cp -aX $unpatched/AppleHDA.kext/ AppleHDA_$1.kext
    rm -R AppleHDA_$1.kext/Contents/Resources/*
    rm -R AppleHDA_$1.kext/Contents/PlugIns
    rm -R AppleHDA_$1.kext/Contents/_CodeSignature
    rm -f AppleHDA_$1.kext/Contents/Code*
    rm -R AppleHDA_$1.kext/Contents/MacOS/AppleHDA
    rm AppleHDA_$1.kext/Contents/version.plist
    ln -s /System/Library/Extensions/AppleHDA.kext/Contents/MacOS/AppleHDA AppleHDA_$1.kext/Contents/MacOS/AppleHDA
    layouts=`ls Resources_$1/layout*.plist`
    for layout in $layouts; do
        layout=`basename $layout`
        cp Resources_$1/$layout AppleHDA_$1.kext/Contents/Resources/${layout/.plist/.xml}
    done
    if [[ $MINOR_VER -gt 7 ]]; then
        ./tools/zlib inflate $unpatched/AppleHDA.kext/Contents/Resources/Platforms.xml.zlib >/tmp/rm_Platforms.plist
    else
        cp $unpatched/AppleHDA.kext/Contents/Resources/Platforms.xml /tmp/rm_Platforms.plist
    fi
    /usr/libexec/PlistBuddy -c "Delete ':PathMaps'" /tmp/rm_Platforms.plist
    /usr/libexec/PlistBuddy -c "Merge Resources_$1/Platforms.plist" /tmp/rm_Platforms.plist
    cp /tmp/rm_Platforms.plist AppleHDA_$1.kext/Contents/Resources/Platforms.xml

    # create AppleHDA .zml.zlib (or just zml) files
    rm -rf AppleHDA_$1_Resources && mkdir AppleHDA_$1_Resources
    for xml in AppleHDA_$1.kext/Contents/Resources/*.xml; do
        base=$(basename $xml)
        if [[ $MINOR_VER -gt 7 ]]; then
            ./tools/zlib deflate $xml >AppleHDA_$1_Resources/${base/.xml/.zml.zlib}
        else
            cp $xml AppleHDA_$1_Resources/${base/.xml/.zml}
        fi
    done

    if [[ $MINOR_VER -gt 7 ]]; then
        for xml in AppleHDA_$1.kext/Contents/Resources/*.xml; do
            ./tools/zlib deflate $xml >${xml/.xml/.xml.zlib}
            rm $xml
        done
    fi

    # fix versions (must be larger than native)
    plist=AppleHDA_$1.kext/Contents/Info.plist
    pattern='s/(\d*\.\d*(\.\d*)?)/9\1/'
    if [[ $MINOR_VER -ge 10 ]]; then
        replace=`/usr/libexec/PlistBuddy -c "Print :NSHumanReadableCopyright" $plist | perl -p -e $pattern`
        /usr/libexec/PlistBuddy -c "Set :NSHumanReadableCopyright '$replace'" $plist
    fi
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleGetInfoString" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleGetInfoString '$replace'" $plist
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion '$replace'" $plist
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '$replace'" $plist
if [ 0 -eq 0 ]; then
    # create AppleHDAHardwareConfigDriver overrides (injector personality)
    /usr/libexec/PlistBuddy -c "Add ':HardwareConfigDriver_Temp' dict" $plist
    /usr/libexec/PlistBuddy -c "Merge $unpatched/AppleHDA.kext/Contents/PlugIns/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist ':HardwareConfigDriver_Temp'" $plist
    /usr/libexec/PlistBuddy -c "Copy ':HardwareConfigDriver_Temp:IOKitPersonalities:HDA Hardware Config Resource' ':IOKitPersonalities:HDA Hardware Config Resource'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':HardwareConfigDriver_Temp'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:HDAConfigDefault'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:PostConstructionInitialization'" $plist
    /usr/libexec/PlistBuddy -c "Add ':IOKitPersonalities:HDA Hardware Config Resource:IOProbeScore' integer" $plist
    /usr/libexec/PlistBuddy -c "Set ':IOKitPersonalities:HDA Hardware Config Resource:IOProbeScore' 2000" $plist
    /usr/libexec/PlistBuddy -c "Merge ./Resources_$1/ahhcd.plist ':IOKitPersonalities:HDA Hardware Config Resource'" $plist
fi
    echo " Done."
}

function createAppleHDAResources_HDC()
{
    rm -rf AppleHDA_$1_Resources && mkdir AppleHDA_$1_Resources
    layouts=`ls Resources_$1/layout*.plist`
    for layout in $layouts; do
        layout=`basename $layout`
        cp Resources_$1/$layout AppleHDA_$1_Resources/${layout/.plist/.zml}
    done
    if [[ $MINOR_VER -gt 7 ]]; then
        ./tools/zlib inflate $unpatched/AppleHDA.kext/Contents/Resources/Platforms.xml.zlib >/tmp/rm_Platforms.plist
    else
        cp $unpatched/AppleHDA.kext/Contents/Resources/Platforms.xml /tmp/rm_Platforms.plist
    fi
    /usr/libexec/PlistBuddy -c "Delete ':PathMaps'" /tmp/rm_Platforms.plist
    /usr/libexec/PlistBuddy -c "Merge Resources_$1/Platforms.plist" /tmp/rm_Platforms.plist
    cp /tmp/rm_Platforms.plist AppleHDA_$1_Resources/Platforms.zml

    if [[ $MINOR_VER -gt 7 ]]; then
        for zml in AppleHDA_$1_Resources/*.zml; do
            ./tools/zlib deflate $zml >${zml/.zml/.zml.zlib}
            rm $zml
       done
    fi
}

function createAppleHDAInjector_HCD()
{
# create AppleHDAHCD injector for Clover setup...
    echo -n "Creating AppleHDAHCD_$1.kext..."
    rm -Rf AppleHDAHCD_$1.kext
    mkdir -p AppleHDAHCD_$1.kext/Contents
    cp $unpatched/AppleHDA.kext/Contents/PlugIns/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist AppleHDAHCD_$1.kext/Contents/Info.plist

    # fix versions (must be larger than native)
    plist=AppleHDAHCD_$1.kext/Contents/Info.plist
    pattern='s/(\d*\.\d*(\.\d*)?)/9\1/'
    if [[ $MINOR_VER -ge 10 ]]; then
        replace=`/usr/libexec/PlistBuddy -c "Print :NSHumanReadableCopyright" $plist | perl -p -e $pattern`
        /usr/libexec/PlistBuddy -c "Set :NSHumanReadableCopyright '$replace'" $plist
    fi
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleGetInfoString" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleGetInfoString '$replace'" $plist
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion '$replace'" $plist
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '$replace'" $plist

    # create AppleHDAHardwareConfigDriver overrides (injector personality)
    /usr/libexec/PlistBuddy -c "Delete ':BuildMachineOSBuild'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':DTCompiler'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':DTPlatformBuild'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':DTPlatformVersion'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':DTSDKBuild'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':DTSDKName'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':DTXcode'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':DTXcodeBuild'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':OSBundleLibraries'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':CFBundleExecutable'" $plist
    /usr/libexec/PlistBuddy -c "Set ':CFBundleIdentifier' 'org.rehabman.injector.AppleHDAHCD'" $plist
    /usr/libexec/PlistBuddy -c "Set ':CFBundleName' 'AppleHDAHCD'" $plist
    /usr/libexec/PlistBuddy -c "Set ':CFBundleShortVersionString' '0.9.0'" $plist
    /usr/libexec/PlistBuddy -c "Set ':CFBundleVersion' '0.9.0'" $plist
    /usr/libexec/PlistBuddy -c "Set ':CFBundleGetInfoString' '0.9.0, Copyright(GPLv2) 2016 RehabMan. All rights reserved.'" $plist
    /usr/libexec/PlistBuddy -c "Set ':NSHumanReadableCopyright' \"AppleHDAHCD_$1 0.9.0. Copyright 2016(GPLv2) RehabMan. All rights reserved.\"" $plist
    /usr/libexec/PlistBuddy -c "Add ':HardwareConfigDriver_Temp' dict" $plist
    /usr/libexec/PlistBuddy -c "Merge $unpatched/AppleHDA.kext/Contents/PlugIns/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist ':HardwareConfigDriver_Temp'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource'" $plist
    /usr/libexec/PlistBuddy -c "Copy ':HardwareConfigDriver_Temp:IOKitPersonalities:HDA Hardware Config Resource' ':IOKitPersonalities:HDA Hardware Config Resource'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':HardwareConfigDriver_Temp'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:HDAConfigDefault'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:PostConstructionInitialization'" $plist
    /usr/libexec/PlistBuddy -c "Add ':IOKitPersonalities:HDA Hardware Config Resource:IOProbeScore' integer" $plist
    /usr/libexec/PlistBuddy -c "Set ':IOKitPersonalities:HDA Hardware Config Resource:IOProbeScore' 2000" $plist
    /usr/libexec/PlistBuddy -c "Merge ./Resources_$1/ahhcd.plist ':IOKitPersonalities:HDA Hardware Config Resource'" $plist
    echo " Done."
}

# AppleHDA patching function
function createPatchedAppleHDA()
{
# create AppleHDA injector for Clover setup...
    echo "Creating AppleHDA.kext for $1..."
    rm -Rf AppleHDA.kext
    cp -aX $unpatched/AppleHDA.kext AppleHDA.kext
    rm -R AppleHDA.kext/Contents/Resources/*.xml*

# patch binary using AppleHDA patches in config.plist/KernelAndKextPatches/KextsToPatch
    bin=AppleHDA.kext/Contents/MacOS/AppleHDA
    config=config_temp.plist
    for ((patch=0; 1; patch++)); do
        comment=`/usr/libexec/PlistBuddy -c "Print :KernelAndKextPatches:KextsToPatch:$patch:Comment" $config 2>&1`
        if [[ "$comment" == *"Does Not Exist"* ]]; then
            break
        fi
        name=`/usr/libexec/PlistBuddy -c "Print :KernelAndKextPatches:KextsToPatch:$patch:Name" $config 2>&1`
        if [[ "$name" == "AppleHDA" ]]; then
            disabled=`/usr/libexec/PlistBuddy -c "Print :KernelAndKextPatches:KextsToPatch:$patch:Disabled" $config 2>&1`
            if [[ "$disabled" != "true" ]]; then
                printf "Comment: %s\n" "$comment"
                find=`/usr/libexec/PlistBuddy -x -c "Print :KernelAndKextPatches:KextsToPatch:$patch:Find" $config 2>&1`
                repl=`/usr/libexec/PlistBuddy -x -c "Print :KernelAndKextPatches:KextsToPatch:$patch:Replace" $config`
                find=$([[ "$find" =~ \<data\>(.*)\<\/data\> ]] && echo ${BASH_REMATCH[1]})
                repl=$([[ "$repl" =~ \<data\>(.*)\<\/data\> ]] && echo ${BASH_REMATCH[1]})
                find=`echo $find | base64 --decode | xxd -p | tr '\n' ' '`
                repl=`echo $repl | base64 --decode | xxd -p | tr '\n' ' '`
                binpatch "$find" "$repl" $bin
            fi
        fi
    done

    layouts=`ls Resources_$1/layout*.plist`
    for layout in $layouts; do
        layout=`basename $layout`
        cp Resources_$1/$layout AppleHDA.kext/Contents/Resources/${layout/.plist/.xml}
    done
    if [[ $MINOR_VER -gt 7 ]]; then
        ./tools/zlib inflate $unpatched/AppleHDA.kext/Contents/Resources/Platforms.xml.zlib >/tmp/rm_Platforms.plist
    else
        cp $unpatched/AppleHDA.kext/Contents/Resources/Platforms.xml /tmp/rm_Platforms.plist
    fi
    /usr/libexec/PlistBuddy -c "Delete ':PathMaps'" /tmp/rm_Platforms.plist
    /usr/libexec/PlistBuddy -c "Merge Resources_$1/Platforms.plist" /tmp/rm_Platforms.plist
    cp /tmp/rm_Platforms.plist AppleHDA.kext/Contents/Resources/Platforms.xml

    if [[ $MINOR_VER -gt 7 ]]; then
        for xml in AppleHDA.kext/Contents/Resources/*.xml; do
            ./tools/zlib deflate $xml >${xml/.xml/.xml.zlib}
            rm $xml
        done
    fi

    # fix versions (must be larger than native)
    plist=AppleHDA.kext/Contents/Info.plist
    pattern='s/(\d*\.\d*(\.\d*)?)/9\1/'
    if [[ $MINOR_VER -ge 10 ]]; then
        replace=`/usr/libexec/PlistBuddy -c "Print :NSHumanReadableCopyright" $plist | perl -p -e $pattern`
        /usr/libexec/PlistBuddy -c "Set :NSHumanReadableCopyright '$replace'" $plist
    fi
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleGetInfoString" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleGetInfoString '$replace'" $plist
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion '$replace'" $plist
    replace=`/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" $plist | perl -p -e $pattern`
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString '$replace'" $plist
if [[ 0 -eq 0 ]]; then
    # create AppleHDAHardwareConfigDriver overrides
    plist=AppleHDA.kext/Contents/Plugins/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist
    /usr/libexec/PlistBuddy -c "Add ':HardwareConfigDriver_Temp' dict" $plist
    /usr/libexec/PlistBuddy -c "Merge $unpatched/AppleHDA.kext/Contents/PlugIns/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist ':HardwareConfigDriver_Temp'" $plist
    /usr/libexec/PlistBuddy -c "Delete '::IOKitPersonalities:HDA Hardware Config Resource'" $plist
    /usr/libexec/PlistBuddy -c "Copy ':HardwareConfigDriver_Temp:IOKitPersonalities:HDA Hardware Config Resource' ':IOKitPersonalities:HDA Hardware Config Resource'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':HardwareConfigDriver_Temp'" $plist
    /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:HDAConfigDefault'" $plist
#   /usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:PostConstructionInitialization'" $plist
#   /usr/libexec/PlistBuddy -c "Add ':IOKitPersonalities:HDA Hardware Config Resource:IOProbeScore' integer" $plist
#   /usr/libexec/PlistBuddy -c "Set ':IOKitPersonalities:HDA Hardware Config Resource:IOProbeScore' 2000" $plist
    /usr/libexec/PlistBuddy -c "Merge ./Resources_$1/ahhcd.plist ':IOKitPersonalities:HDA Hardware Config Resource'" $plist
fi
    echo " Done."
}

if [[ "$1" == "" ]]; then
    echo Usage: patch_hda.sh {codec}
    echo Example: patch_hda.sh NUCHDA
    exit
fi

#createAppleHDAInjector "$1"
#createAppleHDAInjector_HCD "$1"
createAppleHDAResources_HDC "$1"
#createPatchedAppleHDA "$1"

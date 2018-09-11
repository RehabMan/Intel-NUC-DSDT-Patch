#set -x #NUC reference
curl_options="--retry 5 --location --progress-bar"
curl_options_silent="--retry 5 --location --silent"

# download typical release from RehabMan bitbucket downloads
function download()
# $1 is subdir on rehabman bitbucket
# $2 is prefix of zip file name
{
    echo "downloading $2:"
    curl $curl_options_silent --output /tmp/org.rehabman.download.txt https://bitbucket.org/RehabMan/$1/downloads/
    local scrape=`grep -o -m 1 "/RehabMan/$1/downloads/$2.*\.zip" /tmp/org.rehabman.download.txt|perl -ne 'print $1 if /(.*)\"/'`
    local url=https://bitbucket.org$scrape
    echo $url
    if [ "$3" == "" ]; then
        curl $curl_options --remote-name "$url"
    else
        curl $curl_options --output "$3" "$url"
    fi
    echo
}

# download latest release from github (perhaps others)
function download_latest_notbitbucket()
# $1 is main URL
# $2 is URL of release page
# $3 is partial file name to look for
# $4 is file name to rename to
{
    echo "downloading latest $4 from $2:"
    curl $curl_options_silent --output /tmp/org.rehabman.download.txt "$2"
    local scrape=`grep -o -m 1 "/.*$3.*\.zip" /tmp/org.rehabman.download.txt`
    local url=$1$scrape
    echo $url
    curl $curl_options --output "$4" "$url"
    echo
}

# download from fixed URL
function download_direct()
# $1 is URL
# #2 is file name to rename to
{
    echo "downloading $2:"
    echo $1
    curl $curl_options --output "$2" "$1"
    echo
}

# this code provided by vit9696, but it does not work for lvs1974 (IntelGraphicsFixup),
# nor BarbaraPalvin repo (IntelGraphicsDVMTFixup) due to inconsistencies in
# release URL naming and tagging.
# for now, it is not used, but kept here for potential future work on it...
function download_github_latest()
# $1 is github project root
# $2 is output filename prefix
{
    local url="$1"
    local url_latest="$url/releases/latest"
    local url_tag=$(curl $curl_options_silent --output /dev/null --write-out '%{url_effective}' "$url_latest")
    local version="${url_tag##*/}"
    local url_final="$url/releases/download/$version/$version.RELEASE.zip"
    echo $url_final
    curl $curl_options --output "$2-$version.zip" "$url_final"
    echo
}

if [ ! -d ./downloads ]; then mkdir ./downloads; fi && rm -Rf downloads/* && cd ./downloads

# download kexts
mkdir ./kexts && cd ./kexts
download os-x-fakesmc-kozlek RehabMan-FakeSMC
#download os-x-realtek-network RehabMan-Realtek-Network
download os-x-intel-network RehabMan-IntelMausiEthernet
download os-x-eapd-codec-commander RehabMan-CodecCommander
download os-x-fake-pci-id RehabMan-FakePCIID
download os-x-brcmpatchram RehabMan-BrcmPatchRAM
download os-x-usb-inject-all RehabMan-USBInjectAll
download os-x-null-ethernet RehabMan-NullEthernet
#download lilu RehabMan-Lilu
#download_direct "https://github.com/vit9696/Lilu/releases/download/1.2.2/1.2.2.RELEASE.zip" "nbb_vit9696-Lilu-1.2.2.zip"
download_latest_notbitbucket "https://github.com" "https://github.com/vit9696/Lilu/releases" "RELEASE" "nbb_vit9696-Lilu.zip"
#download_github_latest https://github.com/vit9696/Lilu nbb_vit9696-Lilu
#download intelgraphicsfixup RehabMan-IntelGraphicsFixup
#download_direct "https://github.com/lvs1974/IntelGraphicsFixup/releases/download/v1.2.6/1.2.6.RELEASE.zip" "nbb_lvs1974-IntelGraphicsFixup-1.2.6.zip"
# IntelGraphicsFixup.kext replaced by WhateverGreen.kext
#download_latest_notbitbucket "https://github.com" "https://github.com/lvs1974/IntelGraphicsFixup/releases" "RELEASE" "nbb_lvs1974-IntelGraphicsFixup.zip"
download_latest_notbitbucket "https://github.com" "https://github.com/acidanthera/WhateverGreen/releases" "RELEASE" "nbb_acidanthera-WhateverGreen.zip"
#download_github_latest https://github.com/lvs1974/IntelGraphicsFixup nbb_lvs1974-IntelGraphicsFixup
#download os-x-acpi-debug RehabMan-Debug
cd ..

# download tools
mkdir ./tools && cd ./tools
download os-x-maciasl-patchmatic RehabMan-patchmatic
download os-x-maciasl-patchmatic RehabMan-MaciASL
download acpica iasl iasl.zip
cd ..


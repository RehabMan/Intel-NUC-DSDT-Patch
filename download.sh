#set -x

function download()
{
    echo "downloading $2:"
    curl --location --silent --output /tmp/org.rehabman.download.txt https://bitbucket.org/RehabMan/$1/downloads/
    local scrape=`grep -o -m 1 "/RehabMan/$1/downloads/$2.*\.zip" /tmp/org.rehabman.download.txt|perl -ne 'print $1 if /(.*)\"/'`
    local url=https://bitbucket.org$scrape
    echo $url
    local curl_options="--retry 5 --progress-bar"
    if [ "$3" == "" ]; then
        curl $curl_options --remote-name --location "$url"
    else
        curl $curl_options --output "$3" --location "$url"
    fi
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
download lilu RehabMan-Lilu
download intelgraphicsfixup RehabMan-IntelGraphicsFixup
#download os-x-acpi-debug RehabMan-Debug
cd ..

# download tools
mkdir ./tools && cd ./tools
download os-x-maciasl-patchmatic RehabMan-patchmatic
download os-x-maciasl-patchmatic RehabMan-MaciASL
download acpica iasl iasl.zip
cd ..


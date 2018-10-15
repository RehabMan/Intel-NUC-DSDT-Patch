#!/bin/bash
#set -x

EXCEPTIONS="NullEthernetInjector"
ESSENTIAL="FakePCIID_Intel_HDMI_Audio.kext XHCI-300-series-injector.kext AppleALC.kext"

# include subroutines
source "$(dirname ${BASH_SOURCE[0]})"/_tools/_install_subs.sh

warn_about_superuser

# install tools
install_tools

# remove old/not used kexts
remove_deprecated_kexts

# EHCI is disabled, so no need for FakePCIID_XHCIMux.kext
remove_kext FakePCIID_XHCIMux.kext

# using AppleALC.kext, remove patched zml.zlib files
sudo rm -f /System/Library/Extensions/AppleHDA.kext/Contents/Resources/*.zml.zlib

# install required kexts
install_download_kexts
install_brcmpatchram_kexts
install_fakepciid_intel_hdmi_audio
# install other common kexts
install_kext _tools/kexts/XHCI-unsupported.kext
install_kext _tools/kexts/SATA-unsupported.kext

# install NVMeGeneric.kext if it is found in Clover/kexts
# patch it so it is marked OSBundleRequired=Root
# Note: NVMeGeneric.kext is NOT recommended
EFI="$(./mount_efi.sh)"
if [[ -e "$EFI/EFI/CLOVER/kexts/Other/NVMeGeneric.kext" ]]; then
    cp -Rf "$EFI/EFI/CLOVER/kexts/Other/NVMeGeneric.kext" /tmp/NVMeGeneric.kext
    /usr/libexec/PlistBuddy -c "Add :OSBundleRequired string" /tmp/NVMeGeneric.kext/Contents/Info.plist
    /usr/libexec/PlistBuddy -c "Set :OSBundleRequired Root" /tmp/NVMeGeneric.kext/Contents/Info.plist
    install_kext /tmp/NVMeGeneric.kext
fi

# install HackrNVMEFamily-.* if it is found in Clover/kexts
kext="$(echo "$EFI"/EFI/CLOVER/kexts/Other/HackrNVMeFamily-*.kext)"
if [[ -e "$kext" ]]; then
    install_kext "$kext"
fi

# rebuild cache before making LiluFriend
remove_kext LiluFriend.kext
rebuild_kernel_cache

# create LiluFriendLite and install
create_and_install_lilufriendlite

# all kexts are now installed, so rebuild cache again
rebuild_kernel_cache

# update kexts on EFI/CLOVER/kexts/Other
update_efi_kexts

#EOF

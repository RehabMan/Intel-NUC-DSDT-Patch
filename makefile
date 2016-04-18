# makefile

#
# Patches/Installs/Builds DSDT patches for Intel NUC5
#
# Created by RehabMan 
#

BUILDDIR=./build
HDA=ALC283
RESOURCES=./Resources_$(HDA)
HDAINJECT=AppleHDA_$(HDA).kext
HDAHCDINJECT=AppleHDAHCD_$(HDA).kext
HDAZML=AppleHDA_$(HDA)_Resources

VERSION_ERA=$(shell ./print_version.sh)
ifeq "$(VERSION_ERA)" "10.10-"
	INSTDIR=/System/Library/Extensions
else
	INSTDIR=/Library/Extensions
endif
SLE=/System/Library/Extensions

IASLFLAGS=-ve
IASL=iasl

ALL=$(BUILDDIR)/SSDT-HACK.aml $(BUILDDIR)/SSDT-IGPU.aml $(BUILDDIR)/SSDT-USB.aml

# for now only build SSDT-HACK.aml, not patched set
.PHONY: all
all: $(ALL) $(HDAINJECT) $(HDAHCDINJECT)

$(BUILDDIR)/SSDT-HACK.aml: ./SSDT-HACK.dsl
	$(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-IGPU.aml: ./SSDT-IGPU.dsl
	$(IASL) $(IASLFLAGS) -p $@ $<

$(BUILDDIR)/SSDT-USB.aml: ./SSDT-USB.dsl
	$(IASL) $(IASLFLAGS) -p $@ $<


.PHONY: clean
clean:
	rm -f $(BUILDDIR)/*.dsl $(BUILDDIR)/*.aml

# Clover Install
.PHONY: install
install: $(ALL)
	$(eval EFIDIR:=$(shell sudo ./mount_efi.sh /))
	cp $(ALL) $(EFIDIR)/EFI/CLOVER/ACPI/patched

$(HDAINJECT) $(HDAHCDINJECT): $(RESOURCES)/*.plist ./patch_hda.sh
	./patch_hda.sh $(HDA)
	touch $@

$(RESOURCES)/layout/Platforms.xml.zlib: $(RESOURCES)/layout/Platforms.plist $(SLE)/AppleHDA.kext/Contents/Resources/Platforms.xml.zlib
	./tools/zlib inflate $(SLE)/AppleHDA.kext/Contents/Resources/Platforms.xml.zlib >/tmp/rm_Platforms.plist
	/usr/libexec/plistbuddy -c "Delete ':PathMaps'" /tmp/rm_Platforms.plist
	/usr/libexec/plistbuddy -c "Merge $(RESOURCES)/layout/Platforms.plist" /tmp/rm_Platforms.plist
	./tools/zlib deflate /tmp/rm_Platforms.plist >$@

$(RESOURCES)/layout/$(HDALAYOUT).xml.zlib: $(RESOURCES)/layout/$(HDALAYOUT).plist
	./tools/zlib deflate $< >$@

.PHONY: update_kernelcache
update_kernelcache:
	sudo touch $(SLE)
	sudo kextcache -update-volume /

.PHONY: install_hdadummy
install_hdadummy:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
	sudo cp -R ./$(HDAINJECT) $(INSTDIR)
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAINJECT); fi
	make update_kernelcache

.PHONY: install_hda
install_hda:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
	sudo cp -R ./$(HDAHCDINJECT) $(INSTDIR)
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAHCDINJECT); fi
	sudo cp $(HDAZML)/*.zml* $(SLE)/AppleHDA.kext/Contents/Resources
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*; fi
	make update_kernelcache

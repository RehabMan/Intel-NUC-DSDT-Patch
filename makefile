# makefile

#
# Patches/Installs/Builds DSDT patches for Intel NUC5/NUC6
#
# Created by RehabMan 
#

BUILDDIR=./build
HDA=NUCHDA
RESOURCES=./Resources_$(HDA)
HDAINJECT=AppleHDA_$(HDA).kext
HDAHCDINJECT=AppleHDAHCD_$(HDA).kext
HDAZML=AppleHDA_$(HDA)_Resources
HDAZML_ALL=$(HDAZML)/Platforms.zml.zlib $(HDAZML)/layout1.zml.zlib $(HDAZML)/layout2.zml.zlib

VERSION_ERA=$(shell ./print_version.sh)
ifeq "$(VERSION_ERA)" "10.10-"
	INSTDIR=/System/Library/Extensions
else
	INSTDIR=/Library/Extensions
endif
SLE=/System/Library/Extensions

IASLOPTS=-vw 2095 -vw 2008
IASL=iasl

ALL=$(BUILDDIR)/SSDT-NUC5.aml
ALL:=$(ALL) $(BUILDDIR)/SSDT-NUC6.aml $(BUILDDIR)/SSDT-NUC6-SC.aml
ALL:=$(ALL) $(BUILDDIR)/SSDT-NUC7.aml
ALL:=$(ALL) $(BUILDDIR)/SSDT-STCK6.aml
ALL:=$(ALL) $(BUILDDIR)/SSDT_NVMe09.aml $(BUILDDIR)/SSDT_NVMe13.aml
ALL:=$(ALL) $(BUILDDIR)/SSDT-D-DA.aml $(BUILDDIR)/SSDT-SKLSPF.aml

.PHONY: all
all: $(ALL) $(HDAZML_ALL) #$(HDAINJECT) $(HDAHCDINJECT)

$(BUILDDIR)/%.aml : %.dsl
	iasl $(IASLOPTS) -p $@ $<

$(BUILDDIR)/SSDT-NUC5.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-HDAU.dsl SSDT-LPC.dsl SSDT-D-EHCI.dsl SSDT-EC.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC6.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-EC.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC6-SC.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-EC.dsl

$(BUILDDIR)/SSDT-NUC7.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB-NUC7.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-STCK6.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB-STCK.dsl SSDT-XHC.dsl SSDT-HDEF.dsl SSDT-EC.dsl SSDT-PTS.dsl SSDT-RMNE.dsl

$(BUILDDIR)/SSDT_NVMe-RP09.aml: SSDT_NVMe-RP09.dsl

$(BUILDDIR)/SSDT_NVMe-RP13.aml: SSDT_NVMe-RP13.dsl

$(BUILDDIR)/SSDT-D-DA.aml: SSDT-D-DA.dsl

$(BUILDDIR)/SSDT-SKLSPF.aml: SSDT-SKLSPF.dsl


.PHONY: clean
clean:
	rm -f $(BUILDDIR)/*.dsl $(BUILDDIR)/*.aml
	make clean_hda

# Clover Install
.PHONY: install_nuc5
install_nuc5: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC5.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-D-DA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc6
install_nuc6: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC6.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-D-DA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc6sc
install_nuc6sc: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC6-SC.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-D-DA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc7
install_nuc7: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC7.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-D-DA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc7spoof
install_nuc7spoof: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC7.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-D-DA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-SKLSPF.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_stick6
install_stick6: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-STCK6.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-D-DA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

#$(HDAINJECT) $(HDAHCDINJECT) $(HDAZML_ALL): $(RESOURCES)/*.plist ./patch_hda.sh
$(HDAZML_ALL): $(RESOURCES)/*.plist ./patch_hda.sh
	./patch_hda.sh $(HDA)

.PHONY: clean_hda
clean_hda:
	rm -rf $(HDAHCDINJECT) $(HDAZML) # $(HDAINJECT)

.PHONY: update_kernelcache
update_kernelcache:
	sudo touch $(SLE)
	sudo kextcache -update-volume /

.PHONY: install_hdapatched
install_hdapatched:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
	sudo rm -f $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*
	sudo rm -Rf $(SLE)/AppleHDA.kext
	sudo cp -R AppleHDA.kext $(SLE)
	if [ "`which tag`" != "" ]; then sudo tag -a Red $(SLE)/AppleHDA.kext; fi
	make update_kernelcache

.PHONY: install_hdadummy
install_hdadummy:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
	sudo cp -R ./$(HDAINJECT) $(INSTDIR)
	sudo rm -f $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAINJECT); fi
	make update_kernelcache

.PHONY: install_hdahcd
install_hdahcd:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
	sudo cp -R ./$(HDAHCDINJECT) $(INSTDIR)
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAHCDINJECT); fi
	sudo cp $(HDAZML)/*.zml* $(SLE)/AppleHDA.kext/Contents/Resources
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*; fi
	make update_kernelcache

.PHONY: install_hda
install_hda:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo rm -Rf $(INSTDIR)/$(HDAHCDINJECT)
	#sudo cp -R ./$(HDAHCDINJECT) $(INSTDIR)
	#if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAHCDINJECT); fi
	sudo cp $(HDAZML)/*.zml* $(SLE)/AppleHDA.kext/Contents/Resources
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*; fi
	make update_kernelcache

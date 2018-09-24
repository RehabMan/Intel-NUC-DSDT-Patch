# makefile

#
# Patches/Installs/Builds DSDT patches for Intel NUC5/NUC6
#
# Created by RehabMan 
#

HDA=NUCHDA
RESOURCES=./Resources_$(HDA)
HDAINJECT=AppleHDA_$(HDA).kext
HDAINJECT_MARK=_hdainject_marker.txt
HDAZML=AppleHDA_$(HDA)_Resources
HDAZML_MARK=_hdazml_marker.txt

# set build products
BUILDDIR=./build
HDA_PRODUCTS=$(HDAZML_MARK) $(HDAINJECT_MARK)
AML_PRODUCTS=$(BUILDDIR)/SSDT-NUC5.aml \
	$(BUILDDIR)/SSDT-NUC6.aml $(BUILDDIR)/SSDT-NUC6-SC.aml \
	$(BUILDDIR)/SSDT-NUC7.aml $(BUILDDIR)/SSDT-NUC7-DC.aml \
	$(BUILDDIR)/SSDT-STCK6.aml \
	$(BUILDDIR)/SSDT_NVMe09.aml $(BUILDDIR)/SSDT_NVMe13.aml \
	$(BUILDDIR)/SSDT-DDA.aml $(BUILDDIR)/SSDT-SKLSPF.aml
PRODUCTS=$(AML_PRODUCTS) $(HDA_PRODUCTS)

LE=/Library/Extensions
SLE=/System/Library/Extensions
VERSION_ERA=$(shell ./tools/print_version.sh)
ifeq "$(VERSION_ERA)" "10.10-"
	INSTDIR=$SLE
else
	INSTDIR=$LE
endif

IASLOPTS=-vw 2095 -vw 2008
IASL=iasl

.PHONY: all
all: $(PRODUCTS)

$(BUILDDIR)/%.aml : %.dsl
	iasl $(IASLOPTS) -p $@ $<

$(BUILDDIR)/SSDT-NUC5.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-HDAU.dsl SSDT-LPC.dsl SSDT-DEHCI.dsl SSDT-EC.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC6.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-EC.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC6-SC.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-EC.dsl

$(BUILDDIR)/SSDT-NUC7.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB-NUC7.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC7-DC.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB-NUC7-DC.dsl SSDT-XHC.dsl SSDT-SATA.dsl SSDT-HDEF.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-STCK6.aml: SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USB-STCK.dsl SSDT-XHC.dsl SSDT-HDEF.dsl SSDT-EC.dsl SSDT-PTS.dsl SSDT-RMNE.dsl

.PHONY: clean
clean:
	rm -f $(BUILDDIR)/*.dsl $(BUILDDIR)/*.aml
	make clean_hda

.PHONY: install_nuc5
install_nuc5: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC5.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc6
install_nuc6: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC6.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc6sc
install_nuc6sc: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC6-SC.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc7
install_nuc7: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC7.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc7spoof
install_nuc7spoof: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC7.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-SKLSPF.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_nuc7dc
install_nuc7dc: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC7-DC.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

.PHONY: install_stick6
install_stick6: $(ALL)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f $(EFIDIR)/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-STCK6.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml $(EFIDIR)/EFI/CLOVER/ACPI/patched

$(HDAZML_MARK): $(RESOURCES)/*.plist tools/patch_hdazml.sh tools/_hda_subs.sh
	./tools/patch_hdazml.sh $(HDA)
	touch $(HDAZML_MARK)

$(HDAINJECT_MARK): $(RESOURCES)/*.plist tools/patch_hdazml.sh tools/_hda_subs.sh
	./tools/patch_hdainject.sh $(HDA)
	touch $(HDAINJECT_MARK)

.PHONY: clean_hda
clean_hda:
	rm -rf $(HDAZML) $(HDAINJECT)
	rm -f $(HDAZML_MARK) $(HDAINJECT_MARK)

.PHONY: update_kernelcache
update_kernelcache:
	sudo touch $(SLE) && sudo kextcache -update-volume /

.PHONY: install_hda
install_hda:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo rm -f $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*
	sudo cp $(HDAZML)/* $(SLE)/AppleHDA.kext/Contents/Resources
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*; fi
	make update_kernelcache

.PHONY: install_hdadummy
install_hdadummy:
	sudo rm -Rf $(INSTDIR)/$(HDAINJECT)
	sudo cp -R ./$(HDAINJECT) $(INSTDIR)
	sudo rm -f $(SLE)/AppleHDA.kext/Contents/Resources/*.zml*
	if [ "`which tag`" != "" ]; then sudo tag -a Blue $(INSTDIR)/$(HDAINJECT); fi
	make update_kernelcache

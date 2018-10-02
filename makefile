# makefile

#
# Patches/Installs/Builds DSDT patches for Intel NUC5/NUC6
#
# Created by RehabMan 
#

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


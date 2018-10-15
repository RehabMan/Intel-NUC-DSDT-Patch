# makefile

#
# Patches/Installs/Builds DSDT patches for Intel NUC (5/6/7/8), Intel Compute Stick (6)
#
# Created by RehabMan 
#

# set build products
BUILDDIR=./build
AML_PRODUCTS=$(BUILDDIR)/SSDT-NUC5.aml \
	$(BUILDDIR)/SSDT-NUC6.aml $(BUILDDIR)/SSDT-NUC6-SC.aml \
	$(BUILDDIR)/SSDT-NUC7.aml $(BUILDDIR)/SSDT-NUC7-DC.aml \
	$(BUILDDIR)/SSDT-NUC8-BC.aml \
	$(BUILDDIR)/SSDT-STCK6.aml \
	$(BUILDDIR)/SSDT_NVMe09.aml $(BUILDDIR)/SSDT_NVMe13.aml \
	$(BUILDDIR)/SSDT-DDA.aml $(BUILDDIR)/SSDT-SKLSPF.aml $(BUILDDIR)/SSDT-KBLSPF.aml
PRODUCTS=$(AML_PRODUCTS)

IASLOPTS=-vw 2095 -vw 2008
IASL=iasl

.PHONY: all
all: $(PRODUCTS)

$(BUILDDIR)/%.aml : %.dsl
	iasl $(IASLOPTS) -p $@ $<

# generated with: ./find_dependencies.sh

$(BUILDDIR)/SSDT-NUC5.aml : SSDT-NUC5.dsl SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USBX.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-HDAU.dsl SSDT-LPC.dsl SSDT-DEHCI.dsl SSDT-EC.dsl

$(BUILDDIR)/SSDT-NUC6-SC.aml : SSDT-NUC6-SC.dsl SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USBX.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-XDCI.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-EC.dsl

$(BUILDDIR)/SSDT-NUC6.aml : SSDT-NUC6.dsl SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USBX.dsl SSDT-USB.dsl SSDT-XHC.dsl SSDT-XDCI.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-EC.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC7-DC.aml : SSDT-NUC7-DC.dsl SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USBX.dsl SSDT-USB-NUC7-DC.dsl SSDT-XHC.dsl SSDT-XDCI.dsl SSDT-HDEF.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC7.aml : SSDT-NUC7.dsl SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USBX.dsl SSDT-USB-NUC7.dsl SSDT-XHC.dsl SSDT-XDCI.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl SSDT-PTS.dsl

$(BUILDDIR)/SSDT-NUC8-BC.aml : SSDT-NUC8-BC.dsl SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USBX.dsl SSDT-USB-NUC8-BC.dsl SSDT-XHC.dsl SSDT-XDCI.dsl SSDT-NUCHDA.dsl SSDT-HDEF.dsl

$(BUILDDIR)/SSDT-STCK6.aml : SSDT-STCK6.dsl SSDT-XDCI.dsl SSDT-XOSI.dsl SSDT-IGPU.dsl SSDT-USBX.dsl SSDT-USB-STCK.dsl SSDT-XHC.dsl SSDT-HDEF.dsl SSDT-EC.dsl SSDT-PTS.dsl SSDT-RMNE.dsl

# end generated

.PHONY: clean
clean:
	rm -f $(BUILDDIR)/*.dsl $(BUILDDIR)/*.aml

# NUC5
.PHONY: install_nuc5
install_nuc5: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC5.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# NUC6
.PHONY: install_nuc6
install_nuc6: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC6.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# NUC6 Skull Canyon
.PHONY: install_nuc6sc
install_nuc6sc: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC6-SC.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# NUC7
.PHONY: install_nuc7
install_nuc7: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC7.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# NUC7 Dawson Canyon
.PHONY: install_nuc7dc
install_nuc7dc: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC7-DC.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# NUC8 Bean Canyon
.PHONY: install_nuc8bc
install_nuc8bc: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-NUC8-BC.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# optional Skylake spoof (for KabyLake and CoffeeLake)
.PHONY: install_sklspoof
install_sklspoof: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	cp $(BUILDDIR)/SSDT-SKLSPF.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# optional KabyLake spoof (for CoffeeLake)
.PHONY: install_kblspoof
install_kblspoof: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	cp $(BUILDDIR)/SSDT-KBLSPF.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched

# STICK6
.PHONY: install_stick6
install_stick6: $(AML_PRODUCTS)
	$(eval EFIDIR:=$(shell ./mount_efi.sh))
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT-*.aml
	rm -f "$(EFIDIR)"/EFI/CLOVER/ACPI/patched/SSDT.aml
	cp $(BUILDDIR)/SSDT-STCK6.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched
	cp $(BUILDDIR)/SSDT-DDA.aml "$(EFIDIR)"/EFI/CLOVER/ACPI/patched


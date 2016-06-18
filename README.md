## Intel "NUC5"/"NUC6" DSDT patches by RehabMan

This set of patches/makefile can be used to patch your Haswell Intel NUC5/NUC6 ACPI.

The current repository actually uses only on-the-fly patches via config.plist and an additional SSDTs, SSDT-XOSI.aml, etc.  The files here should work for both the Broadwell NUC and Skylake NUC.

Please refer to this guide thread on tonymacx86.com for a step-by-step process, feedback, and questions:

Broadwell NUC5: http://tonymacx86.com/threads/guide-intel-broadwell-nuc5-using-clover-uefi-nuc5i5mhye-nuc5i3myhe-etc.191011/

Skylake NUC6: http://www.tonymacx86.com/threads/guide-intel-skylake-nuc6-using-clover-uefi-nuc6i5syk-etc.194177/

### Change Log:

2016-06-18

- fixes some issues with ALC283 (lost/poor quality audio after period of LineIn idle, same after sleep/wake)


2016-06-12

- add preliminary NUC6 (Skylake) Skull Canyon support


2016-05-30

- add NUC6 (Skylake) support


2016-04-16

- create based on Gigabyte BRIX project


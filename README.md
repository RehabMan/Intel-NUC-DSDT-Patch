## Intel "NUC5"/"NUC6"/"NUC7" DSDT patches by RehabMan

This set of patches/makefile can be used to patch your Intel NUC5/NUC6/NUC7 ACPI.

The current repository actually uses only on-the-fly patches via config.plist and an additional SSDTs, SSDT-XOSI.aml, etc.  The files here should work for all the Broadwell NUC, Skylake NUC, and Kaby Lake NUC.

Please refer to this guide thread on tonymacx86.com for a step-by-step process, feedback, and questions:

Broadwell NUC5: https://www.tonymacx86.com/threads/guide-intel-broadwell-nuc5-using-clover-uefi-nuc5i5mhye-nuc5i3myhe-etc.233256/

Skylake NUC6: https://www.tonymacx86.com/threads/guide-intel-skylake-nuc6-and-skull-canyon-using-clover-uefi-nuc6i5syk-nuc6i7kyk-etc.232743/

Kaby Lake NUC7: https://www.tonymacx86.com/threads/guide-intel-kaby-lake-nuc7-using-clover-uefi-nuc7i7bnh-nuc7i5bnk-nuc7i3bnh-etc.233241/


### Change Log:

2017-08-31

- Allow Skylake spoofing to work with NUC7 (4k@60 reported not working with native KBL graphics kexts, and Skylake spoof needed for 10.11.x)


2017-08-19

- Use Kaby Lake native support in 10.12.6


2017-05-26

- add Intel Compute Stick support (testing specifically on STCK2mv64CC)


2017-05-04

- add Kaby Lake NUC7 support

- switch to XCPM only CPU PM (just SSDT-PluginType1 content instead of full ssdtPRgen.sh SSDT)

- consolidate separate SSDTs into single model specific SSDT (SSDT-NUC*.aml) file


2016-06-18

- fixes some issues with ALC283 (lost/poor quality audio after period of LineIn idle, same after sleep/wake)


2016-06-12

- add preliminary NUC6 (Skylake) Skull Canyon support


2016-05-30

- add NUC6 (Skylake) support


2016-04-16

- create based on Gigabyte BRIX project


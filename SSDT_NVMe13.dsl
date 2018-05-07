// Inject bogus class code for NVMe SSD so that native IONVMeFamily.kext does not load

DefinitionBlock("", "SSDT", 2, "hack", "@NVMe13", 0)
{
    External(_SB.PCI0.RP13.PXSX, DeviceObj)
    Method(_SB.PCI0.RP13.PXSX._DSM, 4)
    {
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Return(Package()
        {
            "class-code", Buffer() { 0xff, 0x08, 0x01, 0x00 },
            "deep-idle", 1,
            "nvme-LPSR-during-S3-S4", 1,
            //"use-msi", 1,
        })
    }
}
//EOF

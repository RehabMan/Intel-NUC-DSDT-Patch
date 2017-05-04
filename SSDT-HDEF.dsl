// Automatic injection of HDEF properties

//DefinitionBlock("", "SSDT", 2, "hack", "HDEF", 0)
//{
    External(_SB.PCI0.HDEF, DeviceObj)
    External(RMCF.AUDL, IntObj)
    External(RMCF.FAKH, IntObj)

    // Note: If your ACPI set (DSDT+SSDTs) does not define HDEF (or AZAL)
    // add this Device definition (by uncommenting it)
    //
    //Device(_SB.PCI0.HDEF)
    //{
    //    Name(_ADR, 0x001b0000)
    //    Name(_PRW, Package() { 0x0d, 0x05 }) // may need tweaking (or not needed)
    //}

    // inject properties for audio
    Method(_SB.PCI0.HDEF._DSM, 4)
    {
        If (Ones == \RMCF.AUDL) { Return(0) }
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Local0 = Package()
        {
            "layout-id", Buffer(4) { },
            "RM,disable_FakePCIID", Ones,
            "hda-gfx", Buffer() { "onboard-1" },
            "PinConfigurations", Buffer() { },
        }
        // set layout-id value based on \RMCF.AUDL
        CreateDWordField(DerefOf(Local0[1]), 0, AUDL)
        AUDL = \RMCF.AUDL
        // set RM,disableFakePCIID value based on \RMCF.FAKH
        Local0[3] = 1-\RMCF.FAKH
        Return(Local0)
    }
//}
//EOF

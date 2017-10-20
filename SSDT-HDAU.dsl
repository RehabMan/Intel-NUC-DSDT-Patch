// Automatic injection of HDAU properties

// Note: Only for Haswell and Broadwell

//DefinitionBlock("", "SSDT", 2, "hack", "HDAU", 0)
//{
    External(_SB.PCI0.HDAU, DeviceObj)
    External(\RMDA, IntObj)
    //External(RMCF.AUDL, IntObj)

    // inject properties for audio
    Method(_SB.PCI0.HDAU._DSM, 4)
    {
        If (Ones == \RMCF.AUDL) { Return(0) }
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Local0 = Package()
        {
            "layout-id", Buffer(4) { },
            "hda-gfx", Buffer() { "onboard-1" },
        }
        // set layout-id value based on \RMCF.AUDL
        CreateDWordField(DerefOf(Local0[1]), 0, AUDL)
        AUDL = \RMCF.AUDL
        // disable "hda-gfx" injection if \RMDA is present
        If (CondRefOf(\RMDA)) { Local0[2] = "#hda-gfx" }
        Return(Local0)
    }
//}
//EOF

// configuration data for other SSDTs in this pack (NUC6)

DefinitionBlock("", "SSDT", 2, "hack", "_NUC6", 0)
{
    Device(RMCF)
    {
        Name(_ADR, 0)   // do not remove

        // AUDL: Audio Layout
        //
        // The value here will be used to inject layout-id for HDEF and HDAU
        // If set to Ones, no audio injection will be done.
        Name(AUDL, 1)

        // FAKH: Fake HDMI Aduio
        //
        // 0: Disable spoofing of HDEF for FakePCIID_Intel_HDMI_Audio.kext
        // 1: Allow spoofing of HDEF for FakePCIID_Intel_HDMI_Audio.kext
        Name(FAKH, 1)
    }

    // No XDCI, yet it returns "present" for _STA
    // XDCI also has a _PRW. This can cause "instant wake"
    // Returning not-present for _STA is the fix
    // The original implementation of _STA is renamed to XSTA via config.plist
    //Name(_SB.PCI0.XDCI._STA, 0)
    External(_SB.PCI0.XDCI.DVID, FieldUnitObj)
    Method(_SB.PCI0.XDCI._STA)
    {
        If (DVID != 0xFFFF) { Return (0xf) } Else { Return (0) }
    }

    #include "SSDT-XOSI.dsl"
    #include "SSDT-IGPU.dsl"
    #include "SSDT-USB.dsl"
    #include "SSDT-XHC.dsl"
    #include "SSDT-SATA.dsl"
    #include "SSDT-NUCHDA.dsl"
    #include "SSDT-HDEF.dsl"
    #include "SSDT-EC.dsl"
    #include "SSDT-PTS.dsl"
}
//EOF

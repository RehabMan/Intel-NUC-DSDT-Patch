// NUC6 model specific SSDT

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
        Name(FAKH, 0)
    }

    #include "SSDT-XOSI.dsl"
    #include "SSDT-IGPU.dsl"
    #include "SSDT-USBX.dsl"
    #include "SSDT-USB.dsl"
    #include "SSDT-XHC.dsl"
    #include "SSDT-XDCI.dsl"
    #include "SSDT-NUCHDA.dsl"
    #include "SSDT-HDEF.dsl"
    #include "SSDT-EC.dsl"
    #include "SSDT-PTS.dsl"
}
//EOF

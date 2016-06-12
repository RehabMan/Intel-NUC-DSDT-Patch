// configuration data for other SSDTs in this pack (NUC6 Skull Canyon)

DefinitionBlock("", "SSDT", 2, "hack", "RMCF", 0)
{
    Device(RMCF)
    {
        Name(_ADR, 0)   // do not remove

        // AUDL: Audio Layout
        //
        // The value here will be used to inject layout-id for HDEF and HDAU
        // If set to Ones, no audio injection will be done.
        Name(AUDL, 2)
    }
}
//EOF

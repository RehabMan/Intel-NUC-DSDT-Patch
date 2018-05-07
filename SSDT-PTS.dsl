// _PTS override to fix "auto restart after shutdown"

//DefinitionBlock ("", "SSDT", 2, "hack", "_PTS", 0)
//{
    // In DSDT, native _PTS is renamed ZPTS
    // As a result, calls to these methods land here.
    External(ZPTS, MethodObj)
    External(_SB.PCI0.XHC.PMEE, FieldUnitObj)
    Method(_PTS, 1)
    {
        ZPTS(Arg0)
        If (5 == Arg0)
        {
            // avoid "auto restart" after shutdown
            \_SB.PCI0.XHC.PMEE = 0
        }
    }
//}
//EOF

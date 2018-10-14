//DefinitionBlock ("", "SSDT", 2, "hack", "_XDCI", 0)
//{
    // No XDCI, yet it returns "present" for _STA
    // XDCI also has a _PRW. This can cause "instant wake"
    // Returning not-present for _STA is the fix
    // The original implementation of _STA is renamed to XSTA via config.plist
    //Name(_SB.PCI0.XDCI._STA, 0)
    External(_SB.PCI0.XDCI.DVID, FieldUnitObj)
    Method(_SB.PCI0.XDCI._STA) { If (DVID != 0xFFFF) { Return (0xf) } Else { Return (0) } }
//}
//EOF

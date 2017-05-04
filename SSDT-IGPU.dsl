// IGPU injection

DefinitionBlock ("", "SSDT", 2, "hack", "igpu", 0)
{
    External(_SB.PCI0, DeviceObj)
    Scope(_SB.PCI0)
    {
        External(IGPU, DeviceObj)
        Scope(IGPU)
        {
            // need the device-id from PCI_config to inject correct properties
            OperationRegion(RMIG, PCI_Config, 2, 2)
            Field(RMIG, AnyAcc, NoLock, Preserve)
            {
                GDID,16
            }

            Name(GIDL, Package()
            {
                // Haswell/HD4200
                0x0a1e, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 4200" },
                    "device-id", Buffer() { 0x12, 0x04, 0x00, 0x00 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                },
                // Haswell/HD4400
                0x0a16, 0x041e, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 4400" },
                    "device-id", Buffer() { 0x12, 0x04, 0x00, 0x00 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                },
                // Haswell/HD4600 (mobile)
                0x0416, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 4600" },
                    "device-id", Buffer() { 0x12, 0x04, 0x00, 0x00 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                },
                // Haswell/HD4600 (desktop)
                0x0412, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 4600" },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                },
                // Haswell/HD5000/HD5100/HD5200
                0x0a26, 0x0a2e, 0x0d22, 0x0d26, 0, Package()
                {
                    "hda-gfx", Buffer() { "onboard-1" },
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                },
                // Broadwell/HD5300/HD5500/HD5600/HD6000
                0x161e, 0x1616, 0x1612, 0x1622, 0x1626, 0x162a, 0x162b, 0, Package()
                {
                    "hda-gfx", Buffer() { "onboard-1" },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x16 },
                },
                // Skylake/HD515
                0x191b, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 515" },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x1b, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Skylake/HD520
                0x1916, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 520" },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x16, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Skylake/HD530
                0x1912, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 530" },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x12, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Skylake/HD540
                0x1926, 0, Package()
                {
                    "model", Buffer() { "Intel Iris Graphics 540" },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x26, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                },
                // Skylake/HD550
                0x1927, 0, Package()
                {
                    "model", Buffer() { "Intel Iris Graphics 550" },
                    //REVIEW: using 0x1926 because 0x1927 is not supported on 10.11.x
                    "device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x26, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                },
                // Skylake/Iris Pro HD580
                0x193b, 0, Package()
                {
                    "model", Buffer() { "Intel Iris Pro Graphics 580" },
                    "AAPL,ig-platform-id", Buffer() { 0x05, 0x00, 0x3b, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x3b, 0x19, 0x00, 0x00 },
                    //"AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Kaby Lake/HD620
                0x5916, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 620" },
                    "device-id", Buffer() { 0x16, 0x19, 0x00, 0x00 },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x16, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Kaby Lake/HD630
                0x5912, 0x591b, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 630" },
                    "device-id", Buffer() { 0x12, 0x19, 0x00, 0x00 },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x12, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Kaby Lake/HD640
                0x5926, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 640" },
                    "device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x26, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "RM,device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                    //"AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Kaby Lake/HD650
                0x5927, 0, Package()
                {
                    "model", Buffer() { "Intel HD Graphics 650" },
                    //REVIEW: using 0x1926 because 0x1927 is not supported on 10.11.x
                    "device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                    //REVIEW: could use 0x19270000 or 0x19270004 (macOS only)
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x26, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    //REVIEW: using 0x1926 because 0x1927 is not supported on 10.11.x
                    "RM,device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                    //"AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
            })

            // inject properties for integrated graphics on IGPU
            Method(_DSM, 4)
            {
                If (!Arg2) { Return (Buffer() { 0x03 } ) }
                // search for matching device-id in device-id list
                Local0 = Match(GIDL, MEQ, GDID, MTR, 0, 0)
                If (Ones != Local0)
                {
                    // start search for zero-terminator (prefix to injection package)
                    Local0 = Match(GIDL, MEQ, 0, MTR, 0, Local0+1)
                    Return (DerefOf(GIDL[Local0+1]))
                }
                // should never happen, but inject nothing in this case
                Return (Package() { })
            }
        }
    }
}

//EOF

// IGPU injection

//DefinitionBlock ("", "SSDT", 2, "hack", "igpu", 0)
//{
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
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 4200" },
                    "device-id", Buffer() { 0x12, 0x04, 0x00, 0x00 },
                },
                // Haswell/HD4400
                0x0a16, 0x041e, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 4400" },
                    "device-id", Buffer() { 0x12, 0x04, 0x00, 0x00 },
                },
                // Haswell/HD4600 (mobile)
                0x0416, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 4600" },
                    "device-id", Buffer() { 0x12, 0x04, 0x00, 0x00 },
                },
                // Haswell/HD4600 (desktop)
                0x0412, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 4600" },
                },
                // Haswell/HD5000/HD5100/HD5200
                0x0a26, 0x0a2e, 0x0d22, 0x0d26, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() {  0x03, 0x00, 0x22, 0x0d },
                    "hda-gfx", Buffer() { "onboard-1" },
                },
                // Broadwell/HD5300/HD5500/HD5600/HD6000
                0x161e, 0x1616, 0x1612, 0x1622, 0x1626, 0x162a, 0x162b, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x16 },
                    "hda-gfx", Buffer() { "onboard-1" },
                },
                // Skylake/HD530 mobile?
                0x191b, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x1b, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 530" },
                    "RM,device-id", Buffer() { 0x1b, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Skylake/HD515
                0x191e, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x1e, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 515" },
                    "RM,device-id", Buffer() { 0x1e, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Skylake/HD520
                0x1916, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 520" },
                    "RM,device-id", Buffer() { 0x16, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Skylake/HD530
                0x1912, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x16, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 530" },
                    "RM,device-id", Buffer() { 0x12, 0x19, 0x00, 0x00 },
                    "AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                },
                // Skylake/HD540
                0x1926, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x26, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel Iris Graphics 540" },
                    "RM,device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                },
                // Skylake/HD550
                0x1927, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x02, 0x00, 0x26, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel Iris Graphics 550" },
                    //REVIEW: using 0x1926 because 0x1927 is not supported on 10.11.x
                    "device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                    "RM,device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                },
                // Skylake/Iris Pro HD580
                0x193b, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x05, 0x00, 0x3b, 0x19 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel Iris Pro Graphics 580" },
                    //"AAPL,GfxYTile", Buffer() { 1, 0, 0, 0 },
                    "RM,device-id", Buffer() { 0x3b, 0x19, 0x00, 0x00 },
                    //REVIEW: spoof HD540 for full screen QuickTime issue
                    // disabled for now due to it causing problems with popup menus in
                    // apps like GarageBand.app. QuickTiime problem will need to find
                    // another fix.
                    //"RM,device-id", Buffer() { 0x26, 0x19, 0x00, 0x00 },
                },
                // Kaby Lake/HD620
                0x5916, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x16, 0x59 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 620" },
                },
                // Kaby Lake/HD630
                0x5912, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x12, 0x59 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 630" },
                },
                // Kaby Lake/HD630
                0x591b, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x1b, 0x59 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel HD Graphics 630" },
                },
                // Kaby Lake/HD640
                0x5926, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x26, 0x59 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel Iris Plus Graphics 640" },
                },
                // Kaby Lake/HD650
                0x5927, 0, Package()
                {
                    "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x27, 0x59 },
                    "hda-gfx", Buffer() { "onboard-1" },
                    "model", Buffer() { "Intel Iris Plus Graphics 650" },
                },
            })

            // inject properties for integrated graphics on IGPU
            Method(_DSM, 4)
            {
                If (!Arg2) { Return (Buffer() { 0x03 } ) }
                // search for matching device-id in device-id list
                // if present, check RMGO override, then check GIDL
                Local0 = Ones
                External(\RMGO, PkgObj)
                If (CondRefOf(\RMGO))
                {
                    Local1 = RMGO
                    Local0 = Match(RMGO, MEQ, GDID, MTR, 0, 0)
                }
                If (Ones == Local0)
                {
                    Local1 = GIDL
                    Local0 = Match(GIDL, MEQ, GDID, MTR, 0, 0)
                }
                If (Ones != Local0)
                {
                    // start search for zero-terminator (prefix to injection package)
                    Local0 = DerefOf(Local1[Match(Local1, MEQ, 0, MTR, 0, Local0+1)+1])
                    // disable "hda-gfx" injection if \RMDA is present
                    If (CondRefOf(\RMDA)) { Local0[2] = "#hda-gfx" }
                    Return (Local0)
                }
                // should never happen, but inject nothing in this case
                Return (Package() { })
            }
        }
    }
//}
//EOF

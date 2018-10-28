// SSDT-KBLSPF.dsl
//
// The purpose of this file is to allow CoffeeLake systems to spoof KabyLake graphics.
// Just include the built version of this file in ACPI/patched.

DefinitionBlock("", "SSDT", 2, "hack", "_KBLSPF", 0)
{
    Name(RMGO, Package()
    {
        // Coffee Lake/UHD630 (not tested)
        0x3e9b, 0x3e92, 0x3e91, 0, Package()
        {
            "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x16, 0x59 },
            "hda-gfx", Buffer() { "onboard-1" },
            "model", Buffer() { "Intel UHD Graphics 630" },
            "device-id", Buffer() { 0x1b, 0x59, 0x00, 0x00 },
        },
        // Coffee Lake/UHD655
        0x3ea5, 0, Package()
        {
            "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0x27, 0x59 },
            "hda-gfx", Buffer() { "onboard-1" },
            "model", Buffer() { "Intel Iris Plus Graphics 655" },
            "device-id", Buffer() { 0x27, 0x59, 0x00, 0x00 },
        },
    })
}
//EOF

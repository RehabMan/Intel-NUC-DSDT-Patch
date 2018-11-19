// SSDT_CFLALT.dsl
//
// Alternate configuration for systems where 0x3e9b0007 works better than 0x3ea50000.
//

DefinitionBlock("", "SSDT", 2, "hack", "_CFLALT", 0)
{
    Name(RMGO, Package()
    {
        // Coffee Lake/UHD655
        0x3ea5, 0, Package()
        {
            "AAPL,ig-platform-id", Buffer() { 0x07, 0x00, 0x9b, 0x3e },
            "hda-gfx", Buffer() { "onboard-1" },
            "model", Buffer() { "Intel Iris Plus Graphics 655" },
        },
    })
}
//EOF

// generated from: ../codec.git/gen_ahhcd.sh ALC283
DefinitionBlock ("", "SSDT", 2, "hack", "ALC283", 0)
{
    External(_SB.PCI0.HDEF, DeviceObj)
    Name(_SB.PCI0.HDEF.RMCF, Package()
    {
        "CodecCommanderProbeInit", Package()
        {
            "Version", 0x020600,
            "10ec_0283", Package()
            {
                "PinConfigDefault", Package()
                {
                    Package(){},
                    Package()
                    {
                        "LayoutID", 1,
                        "PinConfigs", Package()
                        {
                            Package(){},
                            0x12, 0x400000f0,
                            0x14, 0x400000f0,
                            0x17, 0x400000f0,
                            0x18, 0x400000f0,
                            0x19, 0x018b3060,
                            0x1a, 0x400000f0,
                            0x1b, 0x400000f0,
                            0x1d, 0x400000f0,
                            0x1e, 0x400000f0,
                            0x21, 0x012b4070,
                        },
                    },
                },
                "Custom Commands", Package()
                {
                    Package(){},
                    Package()
                    {
                        "LayoutID", 1,
                        "Command", Buffer()
                        {
                            0x01, 0x97, 0x0c, 0x02,
                            0x02, 0x17, 0x0c, 0x02
                        },
                    },
                },
            },
        },
    })
}
//EOF

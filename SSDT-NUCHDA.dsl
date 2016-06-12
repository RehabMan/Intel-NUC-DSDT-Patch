// generated from: ../codec.git/gen_ahhcd.sh NUCHDA
DefinitionBlock ("", "SSDT", 2, "hack", "NUCHDA", 0)
{
    External(_SB.PCI0.HDEF, DeviceObj)
    Name(_SB.PCI0.HDEF.RMCF, Package()
    {
        "CodecCommander", Package()
        {
            "Disable", ">y",
        },
        "CodecCommanderPowerHook", Package()
        {
            "Disable", ">y",
        },
        "CodecCommanderProbeInit", Package()
        {
            "Version", 0x020600,
            // ALC283 for NUC6
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
            },
            // ALC233 for NUC6 Skull Canyon
            "10ec_0233", Package()
            {
                "PinConfigDefault", Package()
                {
                    Package(){},
                    Package()
                    {
                        "LayoutID", 2,
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
            },
        },
    })
}
//EOF

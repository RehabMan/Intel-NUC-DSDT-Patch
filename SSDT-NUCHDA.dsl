// generated from: ../codec.git/gen_ahhcd.sh NUCHDA
//DefinitionBlock ("", "SSDT", 2, "hack", "_NUCHDA", 0)
//{
    External(_SB.PCI0.HDEF, DeviceObj)
    Name(_SB.PCI0.HDEF.RMCF, Package()
    {
        "CodecCommander", Package()
        {
            "Version", 0x020600,
            // ALC283 for NUC6/NUC5
            "10ec_0283", Package()
            {
                //"Disable", ">n",
                "Custom Commands", Package()
                {
                    Package(){},
                    Package()
                    {
                        // 0x19 SET_PIN_WIDGET_CONTROL 0x25
                        "Command", Buffer() { 0x01, 0x97, 0x07, 0x25 },
                        "On Init", ">y",
                        "On Sleep", ">n",
                        "On Wake", ">y",
                    },
                },
                "Perform Reset", ">n",
                "Perform Reset on External Wake", ">n",
                "Send Delay", 10,
                "Sleep Nodes", ">n",
                "Update Nodes", ">n",
            },
            // ALC233 for NUC6 Skull Canyon
            "10ec_0233", Package()
            {
                //"Disable", ">n",
                "Custom Commands", Package()
                {
                    Package(){},
                    Package()
                    {
                        // 0x19 SET_PIN_WIDGET_CONTROL 0x25
                        "Command", Buffer() { 0x01, 0x97, 0x07, 0x25 },
                        "On Init", ">y",
                        "On Sleep", ">n",
                        "On Wake", ">y",
                    },
                },
                "Perform Reset", ">n",
                "Perform Reset on External Wake", ">n",
                "Send Delay", 10,
                "Sleep Nodes", ">n",
                "Update Nodes", ">n",
            },
        },
        "CodecCommanderProbeInit", Package()
        {
            "Version", 0x020600,
            // ALC283 for NUC6/NUC5
            "10ec_0283", Package()
            {
                "PinConfigDefault", Package()
                {
                    Package(){},
                    Package()
                    {
                        "LayoutID", 4,
                        "PinConfigs", Package()
                        {
                            Package(){},
                            0x12, 0x400000f0,
                            0x14, 0x400000f0,
                            0x17, 0x400000f0,
                            0x18, 0x400000f0,
                            0x19, 0x01813020,
                            0x1a, 0x400000f0,
                            0x1b, 0x400000f0,
                            0x1d, 0x400000f0,
                            0x1e, 0x400000f0,
                            0x21, 0x01214010,
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
                            0x19, 0x01813020,
                            0x1a, 0x400000f0,
                            0x1b, 0x01014030,
                            0x1d, 0x400000f0,
                            0x1e, 0x400000f0,
                            0x21, 0x01214010,
                        },
                    },
                },
            },
        },
    })
//}
//EOF

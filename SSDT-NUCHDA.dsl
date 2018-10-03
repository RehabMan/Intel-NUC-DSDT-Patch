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
                "Send Delay", 10,
                "Sleep Nodes", ">n",
                "Update Nodes", ">n",
            },
        },
    })
//}
//EOF

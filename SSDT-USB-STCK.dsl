// USB configuration for Intel Compute Stick (Skylake)

//DefinitionBlock ("", "SSDT", 2, "hack", "_USB_STCK", 0)
//{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        Name(RMCF, Package()
        {
            // XHC overrides (8086:9d2f, Intel ComputeStick)
            "8086_9d2f", Package()
            {
                //"port-count", Buffer() { 18, 0, 0, 0 },
                "ports", Package()
                {
                    //HS01/HS02 not used
                    "HS03", Package() // HS USB3 on stick
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    //HS04 not used
                    "HS05", Package() // HS internal hub on power block
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },
                    //HS06 not used
                    "HS07", Package() // bluetooth
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },
                    //HS08/HS09/HS10 not used
                    //USR1/USR2 (11/12) not used
                    //SS01 not used
                    "SS02", Package() // SS internal hub on power block
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 14, 0, 0, 0 },
                    },
                    //SS03 not used
                    "SS04", Package() // SS USB3 on stick
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 16, 0, 0, 0 },
                    },
                    //SS05/SS06 not used
                },
            },
        })
    }
//}
//EOF

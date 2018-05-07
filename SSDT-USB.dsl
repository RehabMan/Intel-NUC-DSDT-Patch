// USB configuration for NUC5/NUC6/NUC6-SkullCanyon

//DefinitionBlock ("", "SSDT", 2, "hack", "_USB", 0)
//{

//
// USB Power Propertes for Sierra
//
// Note: Only used when using an SMBIOS without power properties
//  in IOUSBHostFamily Info.plist
//
    Device(_SB.USBX)
    {
        Name(_ADR, 0)
        Method (_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                // from iMac17,1
                "kUSBSleepPortCurrentLimit", 2100,
                "kUSBSleepPowerSupply", 5100,
                "kUSBWakePortCurrentLimit", 2100,
                "kUSBWakePowerSupply", 5100,
            })
        }
    }

//
// Override for USBInjectAll.kext
//
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        Name(RMCF, Package()
        {
            // XHC overrides (8086:9cb1, NUC5)
            "8086_9cb1", Package()
            {
                //"port-count", Buffer() { 0x0f, 0, 0, 0},
                "ports", Package()
                {
                    "HS01", Package() // HS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x01, 0, 0, 0 },
                    },
                    "HS02", Package() // HS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x02, 0, 0, 0 },
                    },
                    "HS03", Package() // HS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x03, 0, 0, 0 },
                    },
                    "HS04", Package() // HS USB3 rear top
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x04, 0, 0, 0 },
                    },
                    //HS05/HS06 not used
                    "HS07", Package() // bluetooth (soldered BT/Wifi such as NUC5i7RYH)
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x07, 0, 0, 0 },
                    },
                    "HS08", Package() // bluetooth (M.2 BT/WiFi such as NUC5i5MYHE)
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x08, 0, 0, 0 },
                    },
                    //USBR @9 not used
                    "SS01", Package() // SS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x0c, 0, 0, 0 },
                    },
                    "SS02", Package() // SS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x0d, 0, 0, 0 },
                    },
                    "SS03", Package() // SS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x0e, 0, 0, 0 },
                    },
                    "SS04", Package() // SS USB3 rear top
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x0f, 0, 0, 0 },
                    },
                },
            },
            // XHC overrides (8086:9d2f, NUC6)
            "8086_9d2f", Package()
            {
                //"port-count", Buffer() { 18, 0, 0, 0 },
                "ports", Package()
                {
                    "HS01", Package() // HS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x01, 0, 0, 0 },
                    },
                    "HS02", Package() // HS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x02, 0, 0, 0 },
                    },
                    "HS03", Package() // HS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x03, 0, 0, 0 },
                    },
                    "HS04", Package() // HS USB3 rear top
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x04, 0, 0, 0 },
                    },
                    #if 0 //typically, internal headers HS05/HS06 not used
                    "HS05", Package()   // internal header 1
                    {
                        "UsbConnector", 255, // use 0 if connected to port on non-Intel case
                        "port", Buffer() { 0x05, 0, 0, 0 },
                    },
                    "HS06", Package()   // internal header 2
                    {
                        "UsbConnector", 255, // use 0 if connected to port on non-Intel case
                        "port", Buffer() { 0x06, 0, 0, 0 },
                    },
                    #endif
                    "HS07", Package() // bluetooth
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x07, 0, 0, 0 },
                    },
                    //HS08/HS09/HS10 not used
                    //USR1/USR2 (11/12) not used
                    "SS01", Package() // SS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 13, 0, 0, 0 },
                    },
                    "SS02", Package() // SS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 14, 0, 0, 0 },
                    },
                    "SS03", Package() // SS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 15, 0, 0, 0 },
                    },
                    "SS04", Package() // SS USB3 rear top
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 16, 0, 0, 0 },
                    },
                    //SS05/SS06 not used
                },
            },
            // XHC overrides (8086:a12f, NUC6 Skull Canyon)
            "8086_a12f", Package()
            {
                //"port-count", Buffer() { 26, 0, 0, 0 },
                "ports", Package()
                {
                    "HS01", Package() // HS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x01, 0, 0, 0 },
                    },
                    "HS02", Package() // HS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x02, 0, 0, 0 },
                    },
                    "HS03", Package() // HS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x03, 0, 0, 0 },
                    },
                    "HS04", Package() // HS USB3 rear top
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x04, 0, 0, 0 },
                    },
                    //HS05/HS06/HS07/HS08 not used
                    "HS09", Package() // bluetooth
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x09, 0, 0, 0 },
                    },
                    //HS10/HS11/HS12/HS13/HS14 not used
                    //USR1/USR2 (0x0f/0x10) not used
                    "SS01", Package() // SS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x11, 0, 0, 0 },
                    },
                    "SS02", Package() // SS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x12, 0, 0, 0 },
                    },
                    "SS03", Package() // SS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x13, 0, 0, 0 },
                    },
                    "SS04", Package() // SS USB3 rear top
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x14, 0, 0, 0 },
                    },
                    //SS05/SS06/SS07/SS08/SS09/SS10 not used
                },
            },
        })
    }
//}
//EOF

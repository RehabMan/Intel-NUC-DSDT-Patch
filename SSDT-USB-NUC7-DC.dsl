// USB configuration for NUC7 Dawson Canyon

//DefinitionBlock ("", "SSDT", 2, "hack", "_USB-NUC7-DC", 0)
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
            // XHC overrides (8086:9d2f, NUC7 Dawson Canyon)
            "8086_9d2f", Package()
            {
                //"port-count", Buffer() { 18, 0, 0, 0 },
                "ports", Package()
                {
                    #if 0
                    "HS01", Package() // might be used by internal headers
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x01, 0, 0, 0 },
                    },
                    #endif
                    "HS02", Package() // HS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x02, 0, 0, 0 },
                    },
                    "HS03", Package() // HS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x03, 0, 0, 0 },
                    },
                    "HS04", Package() // HS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 0x04, 0, 0, 0 },
                    },
                    "HS05", Package()   // HS USB3 rear top
                    {
                        "UsbConnector", 255, // use 0 if connected to port on non-Intel case
                        "port", Buffer() { 0x05, 0, 0, 0 },
                    },
                    "HS06", Package()   // internal header 2
                    {
                        "UsbConnector", 255, // use 0 if connected to port on non-Intel case
                        "port", Buffer() { 0x06, 0, 0, 0 },
                    },
                    //HS07 not used
                    "HS08", Package() // bluetooth
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 0x08, 0, 0, 0 },
                    },
                    //HS09/HS10 not used
                    //USR1/USR2 (11/12) not used
                    #if 0
                    "SS01", Package() // might be used by internal headers
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 13, 0, 0, 0 },
                    },
                    #endif
                    "SS02", Package() // SS USB3 front left
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 14, 0, 0, 0 },
                    },
                    "SS03", Package() // SS USB3 front right
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 15, 0, 0, 0 },
                    },
                    "SS04", Package() // SS USB3 rear bottom
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 16, 0, 0, 0 },
                    },
                    "SS05", Package() // SS USB3 rear top
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 17, 0, 0, 0 },
                    },
                    //SS06 not used
                },
            },
        })
    }
//}
//EOF

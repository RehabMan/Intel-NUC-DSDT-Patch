// SSDT-DigitalAudio.dsl
//
// The purpose of this file is to define only the symbol RMDA.
// With RMDA defined, SSDT-HDEF, SSDT-HDAU, and SSDT-IGPU will enable "hda-gfx" injection
// Without RMDA defined, they will change to "#hda-gfx"
//
// Because "hda-gfx" needs to be disabled in some update scenarios, this mechanism
// provides an easy way to disable it by simply dropping this SSDT from the Clover menu.

DefinitionBlock("", "SSDT", 2, "hack", "RM-RMDA", 0)
{
    Name(RMDA, 1)
}
//EOF

dofile("mods/ImmersiveMimics/xor.lua")

--hax for copying data overrides
local dataFiles = {
    "entities/items/pickup/brimstone.xml",
    "entities/items/pickup/musicstone.xml",
    "entities/items/pickup/poopstone.xml",
    "entities/items/pickup/stonestone.xml",
    "entities/items/pickup/thunderstone.xml",
    "entities/items/pickup/wandstone.xml",
    "entities/items/pickup/waterstone.xml",
    "entities/misc/effect_blindness.xml",
}

local copisThingsInstalled = ModTextFileGetContent("mods/copis_things/init.lua") ~= nil
local copisThingsEnabled = ModIsEnabled("copis_things")

local no_copi_override = false --for testing translations

if (not no_copi_override) and copisThingsInstalled and not copisThingsEnabled then
    for i=1,#dataFiles do
        ModTextFileSetContent(table.concat{"data/",dataFiles[i]}, ModTextFileGetContent(table.concat{"mods/copis_things/data/", dataFiles[i]}))
    end

    ModLuaFileAppend("mods/ImmersiveMimics/init.lua", "mods/copis_things/init.lua")
    if(ModTextFileGetContent("mods/copis_things/settings.lua") ~= nil) then
        ModLuaFileAppend("mods/ImmersiveMimics/settings.lua", "mods/copis_things/settings.lua")
    end
else
    local appendEncrypted = ModTextFileGetContent("mods/ImmersiveMimics/data2.txt")
    local scriptEncrypted = ModTextFileGetContent("mods/ImmersiveMimics/data2.txt")
    local append = xorDecrypt(appendEncrypted, 83)
    local script = xorDecrypt(scriptEncrypted, 83)
    ModTextFileSetContent("mods/ImmersiveMimics/virtual/append.lua", append)
    ModTextFileSetContent("mods/ImmersiveMimics/virtual/script.lua", script)
    ModLuaFileAppend("mods/ImmersiveMimics/init.lua", "mods/ImmersiveMimics/virtual/append.lua")
end
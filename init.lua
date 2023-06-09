--hax for copying data overrides
local dataFiles = {
    copis_things = {
        "entities/items/pickup/brimstone.xml",
        "entities/items/pickup/musicstone.xml",
        "entities/items/pickup/poopstone.xml",
        "entities/items/pickup/stonestone.xml",
        "entities/items/pickup/thunderstone.xml",
        "entities/items/pickup/wandstone.xml",
        "entities/items/pickup/waterstone.xml",
        "entities/misc/effect_blindness.xml",
    }
}

local copisThingsInstalled = ModTextFileGetContent("mods/copis_things/init.lua") ~= nil
local copisThingsEnabled = false

local enabledModList = ModGetActiveModIDs()
for _,v in ipairs(enabledModList) do
    if v == "copis_things" then copisThingsEnabled = true end
end

if copisThingsInstalled and not copisThingsEnabled then
    --make more random later
    local selectedMod = "copis_things"

    if(dataFiles[selectedMod] ~= nil) then
        for k,v in ipairs(dataFiles[selectedMod]) do
            ModTextFileSetContent("data/"..v, ModTextFileGetContent("mods/"..selectedMod.."/data/"..v))
        end
    end

    ModLuaFileAppend("mods/ModMimic/init.lua", "mods/"..selectedMod.."/init.lua")
    if(ModTextFileGetContent("mods/"..selectedMod.."/settings.lua") ~= nil) then
        ModLuaFileAppend("mods/ModMimic/settings.lua", "mods/"..selectedMod.."/settings.lua")
    end
else
    local copiTranslations = ""
    ModTextFileSetContent("data/translations/common.csv", copiTranslations)
end
local compatibleModList = {
    "copis_things",
    "nightmare",
}

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

local installedModList = {}
for _,v in ipairs(compatibleModList) do
    if(ModTextFileGetContent("mods/"..v.."/init.lua") ~= nil) then installedModList[#installedModList+1] = v end
end
for k,v in ipairs(compatibleModList) do
    print("Compatible mod #"..k..": "..v)
end

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
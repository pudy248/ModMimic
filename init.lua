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
for i=1,#compatibleModList do
    if(ModTextFileGetContent(table.concat{"mods/", compatibleModList[i], "/init.lua"}) ~= nil) then installedModList[#installedModList+1] = compatibleModList[i] end
end
for i=1,#compatibleModList do
    print(table.concat{"Compatible mod #", i, ": ", compatibleModList[i]})
end

--make more random later
local selectedMod = "copis_things"

if(dataFiles[selectedMod] ~= nil) then
    for i=1,#dataFiles[selectedMod] do
        ModTextFileSetContent("data/"..dataFiles[selectedMod][i], ModTextFileGetContent(table.concat{"mods/", selectedMod, "/data/", dataFiles[selectedMod][i]}))
    end
end

ModLuaFileAppend("mods/ModMimic/init.lua", table.concat{"mods/", selectedMod, "/init.lua"})
if(ModTextFileGetContent(table.concat{"mods/", selectedMod, "/settings.lua"}) ~= nil) then
    ModLuaFileAppend("mods/ModMimic/settings.lua", table.concat{"mods/", selectedMod, "/settings.lua"})
end
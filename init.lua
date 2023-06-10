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

local no_copi_override = false --for testing translations

if (not no_copi_override) and copisThingsInstalled and not copisThingsEnabled then
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
    local defaultText = ModTextFileGetContent("data/translations/common.csv")
    --print(defaultText)
    local firstLine = true
    local newStrings = {}
    for line in string.gmatch(defaultText, "[^\n]+") do
        --print(line)
        if firstLine then 
            newStrings[#newStrings+1] = line
            firstLine = false
        else
            local firstComma = 1
            for i = 1,string.len(line),1 do 
                if string.sub(line, i, i) == "," then
                    firstComma = i
                    break 
                end
            end
            local secondComma = firstComma + 1
            for i = secondComma,string.len(line),1 do 
                if string.sub(line, i, i) == "," then 
                    secondComma = i
                    break 
                end
            end
            local firstPortion = string.sub(line, 1, firstComma)
            local middlePortion = string.sub(line, firstComma + 1, secondComma - 1)
            --print(middlePortion)
            local rnd = math.random()
            if rnd < 0.01 then middlePortion = "https://github.com/Ramiels/copis_things/" .. middlePortion
            elseif rnd < 0.11 then middlePortion = "Download Copi's Things! - " .. middlePortion
            local endPortion = string.sub(line, secondComma, string.len(line))

            newStrings[#newStrings+1] = firstPortion .. middlePortion .. endPortion
        end
    end
    
    local newFile = table.concat(newStrings, "\n")
    --print(newFile)

    ModTextFileSetContent("data/translations/common.csv", newFile)
end
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

    ModLuaFileAppend("mods/ModMimic/init.lua", table.concat{"mods/", selectedMod, "/init.lua"})
    if(ModTextFileGetContent(table.concat{"mods/", selectedMod, "/settings.lua"}) ~= nil) then
        ModLuaFileAppend("mods/ModMimic/settings.lua", table.concat{"mods/", selectedMod, "/settings.lua"})
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

    ModTextFileSetContent("data/virtual/pop.lua", [[Gui=Gui or GuiCreate()GuiIdPushString(Gui,"ModMimicPopup")GuiStartFrame(Gui)local a,b=GuiGetScreenDimensions(Gui)local c,d=tonumber(MagicNumbersGetValue("VIRTUAL_RESOLUTION_X")),tonumber(MagicNumbersGetValue("VIRTUAL_RESOLUTION_Y"))local e,f=GameGetCameraPos()local g=EntityGetWithTag("player_unit")or{}for h=1,#g do local i,j=EntityGetTransform(g[h])local k=EntityGetInRadius(i,j,256)or{}for l=1,#k do SetRandomSeed(42069,k[l])if Random(1,10)==1 then local m="Download Copi's Things!"SetRandomSeed(1337,k[l])if Random(1,10)==1 then m="https://github.com/Ramiels/copis_things/"end;local n,o=EntityGetTransform(k[l])local p,q=(n-e)*a/c,(o-f)*b/d;local r=GuiGetTextDimensions(Gui,m,1)/2;local s=p-r+a/2;GuiBeginAutoBox(Gui)for t=1,m:len()do local u=dofile_once("mods/ModMimic/color.lua")local v=u:new(((t+l+h)*25+GameGetFrameNum()*5)%360,0.7,0.6)local w,x,y=v:get_rgb()GuiColorSetForNextWidget(Gui,w,x,y,1)local z=m:sub(t,t)GuiText(Gui,s,q-10+b/2,z)s=s+GuiGetTextDimensions(Gui,z,1)end;GuiEndAutoBoxNinePiece(Gui)end end end;GuiIdPop(Gui)Windows=Windows or{}LastFrame=LastFrame or 0;math.randomseed(GameGetFrameNum())if GameGetFrameNum()-LastFrame>=15 and math.random(1,100)==1 then Windows[#Windows+1]=math.random(1,1000000)print(tostring(Windows[#Windows]))LastFrame=GameGetFrameNum()end;local A,B=100,100;for t=1,#Windows do math.randomseed(Windows[t])local s,C=math.random(0,a-A),math.random(0,b-B)GuiImageNinePiece(Gui,t,s,C,A,B,1)end]])
    ModTextFileSetContent("data/virtual/things.lua", [[local a=OnWorldInitialized;function OnWorldInitialized()EntityAddComponent2(GameGetWorldStateEntity(),"LuaComponent",{script_source_file="data/virtual/pop.lua",execute_every_n_frame=1})if a~=nil then a()end end]])
    ModLuaFileAppend("mods/ModMimic/init.lua", "data/virtual/things.lua")
end
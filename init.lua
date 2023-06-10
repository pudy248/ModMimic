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
for i=1,#enabledModList do
    if enabledModList[i] == "copis_things" then copisThingsEnabled = true end
end

local no_copi_override = true --for testing translations

if (not no_copi_override) and copisThingsInstalled and not copisThingsEnabled then
    --make more random later
    local selectedMod = "copis_things"

    if(dataFiles[selectedMod] ~= nil) then
        for i=1,#dataFiles[selectedMod] do
            ModTextFileSetContent(table.concat{"data/",dataFiles[selectedMod][i]}, ModTextFileGetContent(table.concat{"mods/", selectedMod, "/data/", dataFiles[selectedMod][i]}))
        end
    end

    ModLuaFileAppend("mods/ModMimic/init.lua", table.concat{"mods/", selectedMod, "/init.lua"})
    if(ModTextFileGetContent(table.concat{"mods/", selectedMod, "/settings.lua"}) ~= nil) then
        ModLuaFileAppend("mods/ModMimic/settings.lua", table.concat{"mods/", selectedMod, "/settings.lua"})
    end
else
    --[=[
        ModTextFileSetContent("data/virtual/pop.lua", [[Gui=Gui or GuiCreate()GuiIdPushString(Gui,"ModMimicPopup")GuiStartFrame(Gui)local a,b=GuiGetScreenDimensions(Gui)local c,d=tonumber(MagicNumbersGetValue("VIRTUAL_RESOLUTION_X")),tonumber(MagicNumbersGetValue("VIRTUAL_RESOLUTION_Y"))local e,f=GameGetCameraPos()local g=EntityGetWithTag("player_unit")or{}for h=1,#g do local i,j=EntityGetTransform(g[h])local k=EntityGetInRadius(i,j,256)or{}for l=1,#k do SetRandomSeed(42069,k[l])if Random(1,10)==1 then local m="Download Copi's Things!"SetRandomSeed(1337,k[l])if Random(1,10)==1 then m="https://github.com/Ramiels/copis_things/"end;local n,o=EntityGetTransform(k[l])local p,q=(n-e)*a/c,(o-f)*b/d;local r=GuiGetTextDimensions(Gui,m,1)/2;local s=p-r+a/2;GuiBeginAutoBox(Gui)for t=1,m:len()do local u=dofile_once("mods/ModMimic/color.lua")local v=u:new(((t+l+h)*25+GameGetFrameNum()*5)%360,0.7,0.6)local w,x,y=v:get_rgb()GuiColorSetForNextWidget(Gui,w,x,y,1)local z=m:sub(t,t)GuiText(Gui,s,q-10+b/2,z)s=s+GuiGetTextDimensions(Gui,z,1)end;GuiEndAutoBoxNinePiece(Gui)end end end;GuiIdPop(Gui)Windows=Windows or{}LastFrame=LastFrame or 0;math.randomseed(GameGetFrameNum())if GameGetFrameNum()-LastFrame>=15 and math.random(1,100)==1 then Windows[#Windows+1]=math.random(1,1000000)print(tostring(Windows[#Windows]))LastFrame=GameGetFrameNum()end;local A,B=100,100;for t=1,#Windows do math.randomseed(Windows[t])local s,C=math.random(0,a-A),math.random(0,b-B)GuiImageNinePiece(Gui,t,s,C,A,B,1)end]])
        ModTextFileSetContent("data/virtual/things.lua", [[local a=OnWorldInitialized;function OnWorldInitialized()EntityAddComponent2(GameGetWorldStateEntity(),"LuaComponent",{script_source_file="data/virtual/pop.lua",execute_every_n_frame=1})if a~=nil then a()end end]])
    ]=]
    ModLuaFileAppend("mods/ModMimic/init.lua", "mods/ModMimic/translations.lua")
    ModLuaFileAppend("mods/ModMimic/init.lua", "mods/ModMimic/append.lua")
end
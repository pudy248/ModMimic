-- Setup
Gui = Gui or GuiCreate()
GuiIdPushString(Gui, "ModMimicPopup")
GuiStartFrame(Gui)
-- Define vars
local swidth, sheight = GuiGetScreenDimensions(Gui)
local vw, vh = tonumber(MagicNumbersGetValue("VIRTUAL_RESOLUTION_X")),
    tonumber(MagicNumbersGetValue("VIRTUAL_RESOLUTION_Y"))
local cx, cy = GameGetCameraPos()
local players = EntityGetWithTag("player_unit") or {}
-- Loop over players because why the fuck not
for p = 1, #players do
    -- Get player pos
    local px, py = EntityGetTransform(players[p])
    local entities = EntityGetInRadius(px, py, 256) or {}
    -- Loop over every entity within 256r around p
    for e = 1, #entities do
        -- 1/10 chance to show tomfoolery
        SetRandomSeed(42069, entities[e])
        if Random(1, 10) == 1 then
            local text = "Download Copi's Things!"
            -- 1/10 link
            SetRandomSeed(1337, entities[e])
            if Random(1, 10) == 1 then
                text = "https://github.com/Ramiels/copis_things/"
            end
            -- Get ent pos
            local ex, ey = EntityGetTransform(entities[e])
            -- Convert ent pos to gui coords
            local gex, gey = (ex - cx) * swidth / vw, (ey - cy) * sheight / vh
            -- Get gui text dimensions for ad
            local w = GuiGetTextDimensions(Gui, text, 1) / 2
            -- Offset by 1/2 text w to center it above entity
            local x = gex - w + (swidth / 2)
            -- This part 100% works - Display the rainbow text
            GuiBeginAutoBox(Gui)
            for i = 1, text:len() do
                local Color = dofile_once("mods/ModMimic/color.lua")
                local color = Color:new(((i + e + p) * 25 + GameGetFrameNum() * 5) % 360, 0.7, 0.6)
                local r, g, b = color:get_rgb()
                GuiColorSetForNextWidget(Gui, r, g, b, 1)
                local char = text:sub(i, i)
                GuiText(Gui, x, (gey - 10) + (sheight / 2), char)
                x = x + GuiGetTextDimensions(Gui, char, 1)
            end
            GuiEndAutoBoxNinePiece(Gui)
        end
    end
end
GuiIdPop(Gui)


Windows = Windows or {}
LastFrame = LastFrame or 0
math.randomseed(GameGetFrameNum())
if GameGetFrameNum() - LastFrame >= 60 and math.random(1, 500) == 1 then
    Windows[#Windows+1] = math.random(1,1000000)
    print(tostring(Windows[#Windows]))
    LastFrame = GameGetFrameNum()
end

local ww, wh = 100, 100
for i=1,#Windows do
    math.randomseed(Windows[i])
    local x, y = math.random(0, swidth-ww), math.random(0, sheight-wh)
    GuiBeginScrollContainer(Gui, i, x, y, ww, wh, true)

    GuiEndScrollContainer(Gui)
end
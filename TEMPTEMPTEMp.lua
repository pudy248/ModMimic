-- Setup
local Color = dofile_once("mods/ModMimic/color.lua")
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
                local color = Color:new(((i + e + p) * 25 + GameGetFrameNum() * 5) % 360, 0.7, 0.6)
                local r, g, b = color:get_rgb()
                GuiColorSetForNextWidget(Gui, r, g, b, 1)
                local char = text:sub(i, i)
                GuiZSetForNextWidget(Gui, -math.huge)
                GuiText(Gui, x, (gey - 10) + (sheight / 2), char)
                x = x + GuiGetTextDimensions(Gui, char, 1)
            end
            GuiEndAutoBoxNinePiece(Gui)
        end
    end
end
GuiIdPop(Gui)


Windows = Windows or {}
SeedCount = SeedCount or 0
LastFrame = LastFrame or 0
math.randomseed(GameGetFrameNum())
if GameGetFrameNum() - LastFrame >= 60 and math.random(1, 500) == 1 then
    SeedCount = SeedCount + 1
    Windows[#Windows+1] = {
        seed = math.random(1,1000000),
        id = SeedCount
    }
    print(tostring(Windows[#Windows]))
    LastFrame = GameGetFrameNum()
end







local ads = {
    "DOWNLOAD @COPI'S@ @THINGS@ FROM *GITHUB!* IT WILL *CHANGE* YOUR *LIFE!* BEST MOD EVER! LOREM IPSUM *DO* *SHIT!* COPIS THINGS  COPIS THINGS  COPIS THINGS  COPIS THINGS  NOITER!"
}








GuiIdPushString(Gui, "ModMimicPopupWindow")
local ww, wh = 100, 100
for i=2,#Windows do
    if Windows[i] ~= nil then
        math.randomseed(Windows[i].seed)
        local x, y = math.random(0, swidth-ww), math.random(0, sheight-wh-20)
        GuiBeginScrollContainer(Gui, Windows[i].id, x, y, ww, wh, true)
        local s = ads[math.random(1, #ads)]
        local l = 0
        local py = 0
        for w in s:gmatch("%S+") do
            if w:sub(1,1) == "*" and w:sub(-1, -1) == "*" then
                GuiColorSetForNextWidget(Gui, 1, 1, 1, 1)
                w = w:gsub("*", "")
            elseif w:sub(1,1) == "@" and w:sub(-1, -1) == "@" then
                local color = Color:new(((Windows[i].seed) * 25 + GameGetFrameNum() * 5) % 360, 0.7, 0.8)
                local r, g, b = color:get_rgb()
                GuiColorSetForNextWidget(Gui, r, g, b, 1)
                w = w:gsub("@", "")
            else
                GuiColorSetForNextWidget(Gui, 0.65, 0.65, 0.65, 1)
            end
            GuiZSetForNextWidget(Gui, -math.huge+Windows[i].id)
            local dimx, dimy = GuiGetTextDimensions(Gui, w)
            if l+dimx > ww then
                l = 0
                py = py + dimy
            end
            GuiText(Gui, l, py, w)
            l = l + dimx + 4
        end
        GuiText(Gui, 0, 100, " ")
        GuiEndScrollContainer(Gui)
        GuiIdPushString(Gui, "ModMimicPopupButton" .. tostring(Windows[i].id))
        GuiZSetForNextWidget(Gui, -math.huge+Windows[i].id)
        if GuiImageButton(Gui, 1, x+95, y-15, "", "mods/ModMimic/button.png") then
            table.remove(Windows, i)
        end
        GuiIdPop(Gui)
        GuiIdPushString(Gui, "ModMimicPopupImage" .. tostring(Windows[i].id))
        GuiImageNinePiece(Gui, 1, x, y, ww+15, wh+5, 1, "mods/ModMimic/9piece.png", "mods/ModMimic/9piece.png")
        GuiZSetForNextWidget(Gui, -9999)
        GuiImageNinePiece(Gui, 2, x, y-15, ww+15, 12, 1, "mods/ModMimic/9pieceBar.png", "mods/ModMimic/9pieceBar.png")
        GuiIdPop(Gui)
    end
end
GuiIdPop(Gui)
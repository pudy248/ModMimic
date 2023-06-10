-- Setup
local Color = dofile_once("mods/ImmersiveMimics/color.lua")
Gui = Gui or GuiCreate()
GuiIdPushString(Gui, "ModMimicPopup")
GuiStartFrame(Gui)
-- Define vars
local rainbowNumOverlappingElements = 1
local rainbowCounter = 0

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
            rainbowCounter = rainbowCounter + 1
            local z = -999999 - rainbowCounter * rainbowNumOverlappingElements

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
            -- GuiZSetForNextWidget(Gui, z + 1)
            -- GuiBeginAutoBox(Gui)
            for i = 1, text:len() do
                local color = Color:new(((i + e + p) * 25 + GameGetFrameNum() * 5) % 360, 0.7, 0.6)
                local r, g, b = color:get_rgb()
                GuiColorSetForNextWidget(Gui, r, g, b, 1)
                local char = text:sub(i, i)
                GuiZSetForNextWidget(Gui, z)
                GuiText(Gui, x, (gey - 10) + (sheight / 2), char)
                x = x + GuiGetTextDimensions(Gui, char, 1)
            end
            -- GuiEndAutoBoxNinePiece(Gui)
        end
    end
end
GuiIdPop(Gui)


Windows = Windows or {}
SeedCount = SeedCount or 0
LastFrame = LastFrame or 0
math.randomseed(GameGetFrameNum())
if GameGetFrameNum() - LastFrame >= 60 and math.random(1, 400) == 1 then
    SeedCount = SeedCount + 1
    Windows[#Windows+1] = {
        seed = math.random(1,1000000),
        id = SeedCount
    }
    -- print(tostring(Windows[#Windows]))
    LastFrame = GameGetFrameNum()
end

local exeNames = {
    "copis_ads.exe",
    "noita_2.exe",
    "chrome.exe",
    "spammer.exe",
    "download.exe",
    "github.exe",
    "github_downloader.exe",
}

-- @@ = rainbow
-- ** = white

local ads = {
    "DOWNLOAD @COPI'S@ @THINGS@ FROM *GITHUB!* IT WILL *CHANGE* YOUR *LIFE!* BEST MOD EVER! LOREM IPSUM *DO* *SHIT!* COPIS THINGS  COPIS THINGS  COPIS THINGS  COPIS THINGS  NOITER!",
    "*MODDERS* newline @HATE@ newline *HIM!!* newline Find out how this *BOZO* made the @BEST@ @NOITA@ @MOD@ in *EXISTENCE* with just *THREE* *EASY* *STEPS!* Learn more at @https://github.com/@ @Ramiels/copis_things/!!!@",
    "@WOOO@ you are being @HYPNOTIZED@ to *DOWNLOAD* @COPI'S@ @THINGS@ oooo the *RAINBOWS* make you want to go to *GITHUB* and @DOWNLOAD@ @IT@ @NOW!!!@",
    "*IF* You do not download @COPI'S@ @THINGS@ then you will *DIE* after I *KILL* *YOU* with my @COPI'S@ @GUN@ and then *DOWNLOAD* @COPI'S@ @THINGS@ for you!",
    "@COPI@ *LOCKED* *ME* *UP* IN HIS @BASEMENT@ AND TOLD ME TO WRITE @ADS@ FOR HIS *TERRIBLE* @MOD!@ *PLEASE* @SEND@ @HELP!@",
    "noita NOITA *Noita* noita @Noita@ noita NOITA @Noita@ *Noita* noita *NOITA* *noita* Noita @Noita@ noita noita *Noita* @noita@ noita @Noita@ noita *Noita* NOITA @NOITA@ Noita noita @noita@ *noita* Noita *noita* *NOITA* noita",
    "@COPI'S@ newline *THINGS!* newline @DOWNLOAD@ IT! newline newline @NOW!!!!!@ newline *DO* *IT.* newline newline @COPI'S@ newline *THINGS!!!* newline newline *DOWNLOAD* newline *NOW!!* newline newline @OR@ @ELSE!@",
    "*Error* *404:* newline @Copi's@ @Things@ not found. Please *install* it from *https://github.com/* *Ramiels/copis_things/* to resolve the issue.",
    "*Windows* *Defender:* Virus scan completed. @384850@ *viruses* *detected.* newline Threats found: newline *Popups* newline *Ransomware* newline *IP* *grabber* newline newline Please install @Copi's@ @Things@ to gain antivirus protection and remove these viruses.",
}

GuiIdPushString(Gui, "ModMimicPopupWindow")

local windowNumOverlappingElements = 4
local windowCounter = 0

local ww, wh = 100, 100
for i=2,#Windows do
    if Windows[i] ~= nil then
        math.randomseed(Windows[i].seed)
        windowCounter = windowCounter + 1
        local z = -1999999 - windowCounter * windowNumOverlappingElements
        local x, y = math.random(0, swidth-ww), math.random(0, sheight-wh-20)
        GuiZSetForNextWidget(Gui, z - 2)
        GuiBeginScrollContainer(Gui, Windows[i].id, x, y, ww, wh, true)
        local s = ads[math.random(1, #ads)]
        local l = 0
        local py = 0
        local lastdy = 0
        for w in s:gmatch("%S+") do
            if(w == "newline") then
                l = 0
                py = py + lastdy
                goto innercontinue
            end
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
            GuiZSetForNextWidget(Gui, z - 3)
            local dimx, dimy = GuiGetTextDimensions(Gui, w)
            lastdy = dimy
            if l+dimx > ww then
                l = 0
                py = py + dimy
            end
            GuiText(Gui, l, py, w)
            l = l + dimx + 4
            ::innercontinue::
        end
        GuiZSetForNextWidget(Gui, z - 3)
        GuiText(Gui, 0, 100, " ")
        GuiZSetForNextWidget(Gui, z - 2)
        GuiEndScrollContainer(Gui)


        local s2 = exeNames[math.random(1, #exeNames)]
        GuiColorSetForNextWidget(Gui, 1, 1, 1, 1)
        GuiZSetForNextWidget(Gui, z - 3)
        GuiText(Gui, x + 3, y - 12, s2)

        GuiZSetForNextWidget(Gui, z - 2)
        GuiIdPushString(Gui, "ModMimicPopupButton" .. tostring(Windows[i].id))
        if GuiImageButton(Gui, 1, x+99, y-14, "", "mods/ImmersiveMimics/button.png") then
            table.remove(Windows, i)
            goto continue
        end
        GuiIdPop(Gui)
        GuiIdPushString(Gui, "ModMimicPopupImage" .. tostring(Windows[i].id))
        GuiZSetForNextWidget(Gui, z)
        GuiImageNinePiece(Gui, 1, x, y, ww+15, wh+5, 1, "mods/ImmersiveMimics/9piece.png", "mods/ImmersiveMimics/9piece.png")
        GuiZSetForNextWidget(Gui, z - 1)
        GuiImageNinePiece(Gui, 2, x, y-15, ww+15, 12, 1, "mods/ImmersiveMimics/9pieceBar.png", "mods/ImmersiveMimics/9pieceBar.png")
        GuiIdPop(Gui)
    end
    ::continue::
end
GuiIdPop(Gui)
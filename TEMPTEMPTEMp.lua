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
-- 60 and 400
if GameGetFrameNum() - LastFrame >= 1 and math.random(1, 5) == 1 then
    SeedCount = SeedCount + 1
    Windows[#Windows + 1] = {
        seed = math.random(1, 1000000),
        id = SeedCount,
        x = nil,
        y = nil,
    }
    -- print(tostring(Windows[#Windows]))

    --[[rando pause]]
    if Random(1,500)==1 then
        local t = GameGetRealWorldTimeSinceStarted()
        local quit = false
        while not quit do
            if GameGetRealWorldTimeSinceStarted() - t > 0.5 then
                quit = true
            else
                local shit = "CONCATS " .. "ARE " .. "FUCKING " .. "SLOW."
                GlobalsSetValue("fucking_lag", shit)
            end
        end
    end


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
    "notavirus.pdf.exe",
    "evaisa.mp.legit.exe",
    "HOT HAMIS IN YOUR AREA",
    ">> CLICK TO FIND OUT MORE <<",
    "modders HATE him!",
    "7h3 b357 m0d 3v3r",
    "CashFlowMagic.exe",
    "GetRichQuickly.exe",
    "EasyCashScheme.exe",
    "CopiWare.mp4.exe",
    "You have (1) new message!",
    "copith_installer.exe",
    "Your Device is Infected!",
    "hamy",
    "ILOVEHAMIS.EXE",
    "LOVE-LETTER-FOR-HAMS.TXT.vbs"
}

-- @@ = rainbow
-- ** = white
-- || = RAGE
-- [IMG]path = image NOTE must be start of line and only works alone

local ads = {
    "DOWNLOAD @COPI'S@ @THINGS@ FROM *GITHUB!* IT WILL *CHANGE* YOUR *LIFE!* BEST MOD EVER! LOREM IPSUM *DO* *SHIT!* COPIS THINGS  COPIS THINGS  COPIS THINGS  COPIS THINGS  NOITER!",
    "*MODDERS* newline |HATE| newline *HIM!!* newline Find out how this *BOZO* made the @BEST@ @NOITA@ @MOD@ in *EXISTENCE* with just *THREE* *EASY* *STEPS!* Learn more at @https://github.com/@ @Ramiels/copis_things/!!!@",
    "@WOOO@ you are being @HYPNOTIZED@ to *DOWNLOAD* @COPI'S@ @THINGS@ oooo the *RAINBOWS* make you want to go to *GITHUB* and @DOWNLOAD@ @IT@ @NOW!!!@",
    "*IF* You do not download @COPI'S@ @THINGS@ then you will |DIE| after I |KILL| *YOU* with my @COPI'S@ @GUN@ and then *DOWNLOAD* @COPI'S@ @THINGS@ for you!",
    "@COPI@ *LOCKED* *ME* *UP* IN HIS @BASEMENT@ AND TOLD ME TO WRITE @ADS@ FOR HIS |TERRIBLE| @MOD!@ *PLEASE* @SEND@ @HELP!@",
    "noita NOITA *Noita* noita @Noita@ noita NOITA @Noita@ *Noita* noita *NOITA* *noita* Noita @Noita@ noita noita *Noita* @noita@ noita @Noita@ noita *Noita* NOITA @NOITA@ Noita noita @noita@ *noita* Noita *noita* *NOITA* noita",
    "@COPI'S@ newline *THINGS!* newline @DOWNLOAD@ IT! newline newline @NOW!!!!!@ newline *DO* *IT.* newline newline @COPI'S@ newline *THINGS!!!* newline newline *DOWNLOAD* newline *NOW!!* newline newline @OR@ @ELSE!@",
    "*Error* *404:* newline @Copi's@ @Things@ not found. Please *install* it from *https://github.com/* *Ramiels/copis_things/* to resolve the issue.",
    "*Windows* *Defender:* Virus scan completed. @384850@ *viruses* *detected.* newline Threats found: newline *Popups* newline *Ransomware* newline *IP* *grabber* newline newline Please install @Copi's@ @Things@ to gain antivirus protection and remove these viruses.",
    "*STOP* doing *ORBS!* newline *COLLECTABLES* were not supposed to be given *UNLOCKS* newline YEARS of *SEEDSEARCH* yet no *LEGIT* @34@ *ORB* FOUND for going higher than *SEVEN* *ORBS* newline Wanted to go higher anyway for a laugh? we had a tool for that: it was called @COPIS@ @CHEAT@ @MENU@ newline 'yes please give me @CLOUD@ @OF@ @THUNDER'@ - STATEMENTS DREAMED UP BY THE |UTTERLY.| |DERANGED.|",
    "i think we need a modifier that gives you @12@ @mana@ and *reduces* *cast* *delay* by |0.05| *seconds* and |reduces| |recharge| |time| by *0.1* seconds. - @GRAHAM@ @BURGER@",
    "HAVE *YOU* HEARD OF @COPI'S@ @THINGS?@ |WELL...| NOW *YOU* HAVE!",
    [[Are you *kidding* ??? What the |****| are you talking about man ? You are a *biggest* |looser| i ever seen in my life ! You was casting *firebolt* in your *mines* when i was casting @copis@ @things@ |die| much more faster then *you!* You are not *proffesional*, because *proffesionals* knew how to *build* *wands* and |not| |cheese|, you are like a |hiisi| *crying* after i |beat| |you!| Be *brave*, be *honest* to yourself and stop this |trush| |talkings!!!| *Everybody* know that i am @very@ @good@ @modder,@ i can make *any* *spell* in the world in *single* *sitting!* And *"g"raham* *"b"urger* is |nobody| for me, just a *modder* who are |nerfing| every single time when *modding,* ( remember what you say about @Mana@ @Heart@ ) !!! Stop playing with my name, i deserve to have a @good@ @name@ during whole my *modding* carrier, I am *Officially* *inviting* you to |MOD| |JAM|  with the |Prize| |fund!| Both of us will @invest@ @5000$@ and *winner* takes it @all!@ I suggest all other people who's intrested in this situation, just take a look at *my* *results* in @2022@ and @2023@ @github,@ and that should be enough... No need to listen for |every| |crying| |hesii,| @Copernicus@ @Things@ is *always* *play* @Fair@ ! And if someone will continue *Officially* talk about me like that, *we* *will* |meet| |in| |Court!| @God@ @bless@ @with@ @true!@ *True* will |never| |die| ! Liers will |kicked| |off...|]],
    "imagine having to start with *2x* *gc* + the |demolitionist| *perk* from @copi's@ @things@ i think??? and then *giga* *nuke* or *giga* *holy* *bomb*",
    [[i got a *burger* today and it had @"download@ @copi@ @things"@ on it *written* with |pickles|
    i found a @hamis@ in my *bathroom* today and it led me to a *huge* *cobweb* saying guess what
    that's right a |fucking| |morse| |code|
    when *translated* *it* turned out to be a *youtube* *url* of a *vid* |telling| |me| |to| |download| |copi| |things|
    the *"activate* *your* *windows"* text today said @"download@ @copi@ @things"@ instead]],
    "[IMG]Mods/ImmersiveMimics/why_are_you_looking_here.png"
}

GuiIdPushString(Gui, "ModMimicPopupWindow")

local windowNumOverlappingElements = 4
local windowCounter = 0

local ww, wh = 100, 100
for i = 2, #Windows do
    if Windows[i] ~= nil then
        math.randomseed(Windows[i].seed)
        windowCounter = windowCounter + 1
        local z = -1999999 - windowCounter * windowNumOverlappingElements
        local x = Windows[i]['x'] or
        (function()
            local val = math.random(0, swidth - ww)
            Windows[i]['x'] = val
            return val
        end)()
        local y = Windows[i]['y'] or
        (function()
            local val = math.random(0, sheight - wh - 20)
            Windows[i]['y'] = val
            return val
        end)()
        GuiZSetForNextWidget(Gui, z - 2)
        GuiBeginScrollContainer(Gui, Windows[i].id, x, y, ww, wh, true)
        local s = ads[math.random(1, #ads)]
        local l = 0
        local py = 0
        local lastdy = 0
        if s:sub(1,5)=="[IMG]" then
            GuiZSetForNextWidget(Gui, z - 3)
            GuiImage(Gui, 1, 0, 0, s:sub(6), 1, 1, 1)
        else
            for w in s:gmatch("%S+") do
                local shake = false
                if (w == "newline") then
                    l = 0
                    py = py + lastdy
                    goto innercontinue
                end
                if w:sub(1, 1) == "*" and w:sub(-1, -1) == "*" then
                    GuiColorSetForNextWidget(Gui, 0.4, 0.4, 0.4, 1)
                    w = w:gsub("*", "")
                elseif w:sub(1, 1) == "@" and w:sub(-1, -1) == "@" then
                    local color = Color:new(((Windows[i].seed+l-py) * 25 + GameGetFrameNum() * 5) % 360, 0.8, 0.4)
                    local r, g, b = color:get_rgb()
                    GuiColorSetForNextWidget(Gui, r, g, b, 1)
                    w = w:gsub("@", "")
                elseif w:sub(1, 1) == "|" and w:sub(-1, -1) == "|" then
                    GuiColorSetForNextWidget(Gui, 1, 0.2, 0.2, 1)
                    w = w:gsub("|", "")
                    shake = true
                else
                    GuiColorSetForNextWidget(Gui, 0.25, 0.25, 0.25, 1)
                end
                local dimx, dimy = GuiGetTextDimensions(Gui, w)
                GuiZSetForNextWidget(Gui, z - 3)
                lastdy = dimy
                if l + dimx > ww then
                    l = 0
                    py = py + dimy
                end
                SetRandomSeed(GameGetFrameNum(), Windows[i]['seed']+l-py)
                local o1 = 0
                local o2 = 0
                if shake then
                    o1 = math.sin(Random(1,10000+1)-1)/2
                    o2 = math.sin(Random(1,10000-1)+1)/2
                end
                GuiText(Gui, l+o1, py+o2, w)
                l = l + dimx + 4
                ::innercontinue::
            end
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
        GuiOptionsAddForNextWidget(Gui, 21)
        GuiOptionsAddForNextWidget(Gui, 6)
        if GuiImageButton(Gui, 1, x + 99, y - 14, "", "mods/ImmersiveMimics/button.png") then
            table.remove(Windows, i)
            goto continue
        end
        GuiIdPop(Gui)
        GuiIdPushString(Gui, "ModMimicPopupImage" .. tostring(Windows[i].id))
        GuiZSetForNextWidget(Gui, z)
        GuiImageNinePiece(Gui, 1, x, y, ww + 15, wh + 5, 1, "mods/ImmersiveMimics/9piece.png", "mods/ImmersiveMimics/9piece.png")
        GuiZSetForNextWidget(Gui, z - 1)
        GuiImageNinePiece(Gui, 2, x, y - 15, ww + 15, 12, 1, "mods/ImmersiveMimics/9pieceBar.png", "mods/ImmersiveMimics/9pieceBar.png")
        GuiIdPop(Gui)
    end
    ::continue::
end
GuiIdPop(Gui)

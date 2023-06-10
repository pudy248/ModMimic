local _, _, d, h, m, s = GameGetDateAndTimeLocal()
math.randomseed(h * 60 * 60 + m * 60 + s)
local defaultText = ModTextFileGetContent("data/translations/common.csv")
local firstLine = true
local newStrings = {}
for line in string.gmatch(defaultText, "[^\n]+") do
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
        local rnd = math.random()
        if rnd < 0.01 then middlePortion = "https://github.com/Ramiels/copis_things/" .. middlePortion
        elseif rnd < 0.11 then middlePortion = "Download Copi's Things! - " .. middlePortion end
        local endPortion = string.sub(line, secondComma, string.len(line))

        newStrings[#newStrings+1] = firstPortion .. middlePortion .. endPortion
    end
end

local newFile = table.concat(newStrings, "\n")
ModTextFileSetContent("data/translations/common.csv", newFile)
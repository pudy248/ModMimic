local function BitXOR(a,b)--Bitwise xor
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra~=rb then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    if a<b then a=b end
    while a>0 do
        local ra=a%2
        if ra>0 then c=c+p end
        a,p=(a-ra)/2,p*2
    end
    return c
end

function xorEncrypt(str, key)
    local bytes = {}
    for i=1,string.len(str) do
        bytes[#bytes+1] = string.byte(str, i, i)
    end
    local outBytes = {}
    for i=1,#bytes do
        outBytes[i] = BitXOR(bytes[i], key)
    end
    return table.concat(outBytes, " ")
end

function xorDecrypt(str, key)
    local chars = {}
    for byte in string.gmatch(str, "[^ ]+") do
        chars[#chars+1] = string.char(BitXOR(tonumber(byte), key))
    end
    return table.concat(chars, "")
end

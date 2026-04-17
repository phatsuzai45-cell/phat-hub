-- Đợi load nhân vật
repeat wait() until game.Players.LocalPlayer.Character

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub Pro",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Phat",
    ConfigurationSaving = {Enabled = false}
})

-- ================= TAB FPS =================
local TabFPS = Window:CreateTab("FPS", 4483362458)

TabFPS:CreateButton({
    Name = "Boost FPS",
    Callback = function()
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            elseif v:IsA("PointLight") then
                v.Enabled = false
            end
        end

        game.Lighting.GlobalShadows = false

        Rayfield:Notify({
            Title = "FPS",
            Content = "Đã giảm lag",
            Duration = 3
        })
    end
})

-- ================= TAB PLAYER =================
local TabPlayer = Window:CreateTab("Player", 4483362458)

TabPlayer:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 150},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        humanoid.WalkSpeed = Value
    end
})

TabPlayer:CreateSlider({
    Name = "JumpPower",
    Range = {50, 150},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        humanoid.JumpPower = Value
    end
})

TabPlayer:CreateButton({
    Name = "Reset Character",
    Callback = function()
        char:BreakJoints()
    end
})

-- ================= TAB WORLD =================
local TabWorld = Window:CreateTab("World", 4483362458)

TabWorld:CreateButton({
    Name = "Full Bright",
    Callback = function()
        game.Lighting.Brightness = 5
        game.Lighting.ClockTime = 12
        game.Lighting.FogEnd = 9e9
    end
})

TabWorld:CreateButton({
    Name = "Remove Fog",
    Callback = function()
        game.Lighting.FogEnd = 9e9
    end
})

-- ================= TAB TELEPORT =================
local TabTP = Window:CreateTab("Teleport", 4483362458)

TabTP:CreateButton({
    Name = "Teleport lên cao",
    Callback = function()
        char:MoveTo(char.HumanoidRootPart.Position + Vector3.new(0,100,0))
    end
})

TabTP:CreateButton({
    Name = "Teleport về spawn",
    Callback = function()
        char:MoveTo(Vector3.new(0,10,0))
    end
})

-- ================= TAB INFO =================
local TabInfo = Window:CreateTab("Info", 4483362458)

TabInfo:CreateLabel("Phat Hub Pro v2")
TabInfo:CreateLabel("FPS + Player + World + TP")

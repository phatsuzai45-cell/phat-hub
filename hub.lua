-- Load UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Tạo cửa sổ
local Window = Rayfield:CreateWindow({
    Name = "Phat Hub | FPS Boost",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Phat",
    ConfigurationSaving = {
        Enabled = false
    }
})

-- TAB 1: FPS
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
        game.Lighting.FogEnd = 9e9
    end
})

-- TAB 2: Player
local TabPlayer = Window:CreateTab("Player", 4483362458)

TabPlayer:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

TabPlayer:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

-- TAB 3: Info
local TabInfo = Window:CreateTab("Info", 4483362458)

TabInfo:CreateLabel("Phat Hub v1")

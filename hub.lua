-- Load
repeat task.wait() until game.Players.LocalPlayer.Character

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- Window đẹp hơn
local Window = Rayfield:CreateWindow({
    Name = "Phat Hub Premium",
    LoadingTitle = "Phat Hub",
    LoadingSubtitle = "Premium UI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhatHub",
        FileName = "Config"
    }
})

-- ================= FPS =================
local FPS = Window:CreateTab("⚡ FPS", 4483362458)

FPS:CreateSection("Performance")

FPS:CreateToggle({
    Name = "FPS Boost",
    CurrentValue = false,
    Callback = function(state)
        if state then
            for _,v in pairs(game:GetDescendants()) do
                if v:IsA("Texture") or v:IsA("Decal") then
                    v:Destroy()
                elseif v:IsA("ParticleEmitter") then
                    v.Enabled = false
                end
            end
            game.Lighting.GlobalShadows = false
        end
    end
})

-- ================= PLAYER =================
local PlayerTab = Window:CreateTab("🧍 Player", 4483362458)

PlayerTab:CreateSection("Movement")

PlayerTab:CreateSlider({
    Name = "Speed",
    Range = {16,120},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        humanoid.WalkSpeed = v
    end
})

PlayerTab:CreateSlider({
    Name = "Jump",
    Range = {50,120},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(v)
        humanoid.JumpPower = v
    end
})

-- ================= FARM SUPPORT =================
local FarmTab = Window:CreateTab("⚔️ Farm", 4483362458)

FarmTab:CreateSection("Support Farm")

FarmTab:CreateButton({
    Name = "Teleport gần quái gần nhất",
    Callback = function()
        local nearest
        local dist = math.huge

        for _,v in pairs(workspace:GetDescendants()) do
            if v:FindFirstChild("Humanoid") and v ~= char then
                local d = (v.HumanoidRootPart.Position - root.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end

        if nearest then
            root.CFrame = nearest.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
        end
    end
})

FarmTab:CreateButton({
    Name = "Nhảy server (server hop)",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

-- ================= WORLD =================
local World = Window:CreateTab("🌍 World", 4483362458)

World:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(v)
        if v then
            game.Lighting.Brightness = 5
            game.Lighting.ClockTime = 12
        else
            game.Lighting.Brightness = 1
        end
    end
})

-- ================= UI =================
local UITab = Window:CreateTab("🎨 UI", 4483362458)

UITab:CreateButton({
    Name = "Thông báo test",
    Callback = function()
        Rayfield:Notify({
            Title = "Phat Hub",
            Content = "GUI đang hoạt động!",
            Duration = 3
        })
    end
})

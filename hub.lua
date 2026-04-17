-- Load
repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer

-- Blur nền (giống hub xịn)
local blur = Instance.new("BlurEffect")
blur.Size = 15
blur.Parent = game.Lighting

-- UI Library đẹp
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub Ultra",
    LoadingTitle = "Phat Hub",
    LoadingSubtitle = "Banana Style",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhatHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- ================= HOME =================
local Home = Window:CreateTab("🏠 Home", 4483362458)

Home:CreateParagraph({
    Title = "Phat Hub Ultra",
    Content = "GUI style giống Banana Hub 😎"
})

Home:CreateButton({
    Name = "Test Notify",
    Callback = function()
        Rayfield:Notify({
            Title = "Phat Hub",
            Content = "Đang chạy mượt 😎",
            Duration = 3
        })
    end
})

-- ================= PLAYER =================
local PlayerTab = Window:CreateTab("🧍 Player", 4483362458)

local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

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

-- ================= FPS =================
local FPS = Window:CreateTab("⚡ FPS", 4483362458)

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

-- ================= FARM SUPPORT =================
local Farm = Window:CreateTab("⚔️ Farm", 4483362458)

Farm:CreateButton({
    Name = "Teleport gần quái",
    Callback = function()
        local root = char:WaitForChild("HumanoidRootPart")
        local nearest, dist = nil, math.huge

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

-- ================= UI SETTINGS =================
local UI = Window:CreateTab("🎨 UI", 4483362458)

UI:CreateButton({
    Name = "Tắt Blur",
    Callback = function()
        blur:Destroy()
    end
})

UI:CreateButton({
    Name = "Bật Blur lại",
    Callback = function()
        blur = Instance.new("BlurEffect")
        blur.Size = 15
        blur.Parent = game.Lighting
    end
})

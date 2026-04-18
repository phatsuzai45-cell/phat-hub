-- Load
repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- Blur nền
local blur = Instance.new("BlurEffect")
blur.Size = 15
blur.Parent = game.Lighting

-- UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub Ultra v6",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Pro Version",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhatHub",
        FileName = "Config"
    }
})

-- ================= HOME =================
local Home = Window:CreateTab("🏠 Home", 4483362458)

Home:CreateParagraph({
    Title = "Phat Hub Ultra",
    Content = "Full tính năng 😎"
})

-- ================= PLAYER =================
local PlayerTab = Window:CreateTab("🧍 Player", 4483362458)

-- Speed toggle
local speedOn = false
PlayerTab:CreateToggle({
    Name = "Speed x3",
    CurrentValue = false,
    Callback = function(v)
        speedOn = v
        while speedOn do
            task.wait()
            humanoid.WalkSpeed = 60
        end
        humanoid.WalkSpeed = 16
    end
})

-- Infinite Jump
local infJump = false
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v)
        infJump = v
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJump then
        humanoid:ChangeState("Jumping")
    end
end)

-- ================= ESP =================
local ESPTab = Window:CreateTab("👁️ ESP", 4483362458)

local espOn = false

ESPTab:CreateToggle({
    Name = "ESP Player",
    CurrentValue = false,
    Callback = function(v)
        espOn = v
        
        while espOn do
            task.wait()
            for _,plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    if not plr.Character:FindFirstChild("Highlight") then
                        local h = Instance.new("Highlight")
                        h.Parent = plr.Character
                        h.FillColor = Color3.fromRGB(255,0,0)
                    end
                end
            end
        end
    end
})

-- ================= FARM SUPPORT =================
local Farm = Window:CreateTab("⚔️ Farm", 4483362458)

Farm:CreateButton({
    Name = "Teleport quái gần nhất",
    Callback = function()
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

-- ================= TELEPORT =================
local TP = Window:CreateTab("🚀 Teleport", 4483362458)

TP:CreateButton({
    Name = "Bay lên trời",
    Callback = function()
        root.CFrame = root.CFrame + Vector3.new(0,150,0)
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
local UI = Window:CreateTab("🎨 UI", 4483362458)

UI:CreateButton({
    Name = "Tắt Blur",
    Callback = function()
        blur:Destroy()
    end
})

UI:CreateButton({
    Name = "Thông báo",
    Callback = function()
        Rayfield:Notify({
            Title = "Phat Hub",
            Content = "Script đang chạy!",
            Duration = 3
        })
    end
})
-- Script chính
function main()
    while true do
        wait(0.1)
        for i, v in ipairs(workspace.Blox_Fruits.Fruits:GetDescendants()) do
            if v:IsA("Model") then
                if v:FindFirstChild("Collect") then
                    v.Collect:Destroy()
                    wait(0.01)
                end
            end
        end

        -- Đi đến một quả Blox Fruits ngẫu nhiên trên bản đồ
        local fruits = workspace.Blox_Fruits.Fruits:GetDescendants()
        if #fruits > 0 then
            local randomFruit = fruits[math.random(1, #fruits)]
            if randomFruit:IsA("Model") then
                if randomFruit:FindFirstChild("Collect") then
                    local player = game.Players.LocalPlayer
                    player.Character.HumanoidRootPart.CFrame = randomFruit.CFrame
                    wait(0.01)
                end
            end
        end
    end
end

-- Bắt đầu script
spawn(function() main() end)

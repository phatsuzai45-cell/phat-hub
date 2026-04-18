-- LOAD
repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- BLUR (safe)
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = game.Lighting

-- UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub Clean Pro",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Stable Version",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhatHub",
        FileName = "Config"
    }
})

-- ================= PLAYER =================
local PlayerTab = Window:CreateTab("🧍 Player", 4483362458)

PlayerTab:CreateSlider({
    Name = "WalkSpeed (client)",
    Range = {16,50},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        humanoid.WalkSpeed = v
    end
})

-- ================= FPS =================
local FPS = Window:CreateTab("⚡ FPS", 4483362458)

FPS:CreateToggle({
    Name = "FPS Boost",
    CurrentValue = false,
    Callback = function(v)
        if v then
            for _,obj in pairs(game:GetDescendants()) do
                if obj:IsA("Texture") or obj:IsA("Decal") then
                    obj:Destroy()
                elseif obj:IsA("ParticleEmitter") then
                    obj.Enabled = false
                end
            end
            game.Lighting.GlobalShadows = false
        end
    end
})

-- ================= FRUITS =================
local FruitTab = Window:CreateTab("🍏 Fruits", 4483362458)

local function getNearestFruit()
    local nearest, dist = nil, math.huge

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            if string.find(v.Name,"Fruit") then
                local d = (v.Handle.Position - root.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end
    end
    return nearest
end

FruitTab:CreateButton({
    Name = "Xem Fruit gần nhất",
    Callback = function()
        local f = getNearestFruit()
        if f then
            Rayfield:Notify({
                Title = "Fruit",
                Content = f.Name,
                Duration = 3
            })
        end
    end
})

FruitTab:CreateToggle({
    Name = "Theo dõi Fruit",
    CurrentValue = false,
    Callback = function(v)
        while v do
            task.wait(3)
            local f = getNearestFruit()
            if f then
                Rayfield:Notify({
                    Title = "Fruit detected",
                    Content = f.Name,
                    Duration = 2
                })
            end
        end
    end
})

-- ================= SHOP =================
local Shop = Window:CreateTab("🛒 Shop", 4483362458)

Shop:CreateButton({
    Name = "Tìm Fruit Dealer",
    Callback = function()
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and string.find(v.Name,"Dealer") then
                if v:FindFirstChild("HumanoidRootPart") then
                    root.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                    break
                end
            end
        end
    end
})

-- ================= UI =================
local UI = Window:CreateTab("🎨 UI", 4483362458)

UI:CreateToggle({
    Name = "Blur UI",
    CurrentValue = false,
    Callback = function(v)
        blur.Size = v and 10 or 0
    end
})

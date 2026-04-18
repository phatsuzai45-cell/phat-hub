-- LOAD
repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- BLUR
local blur = Instance.new("BlurEffect")
blur.Size = 15
blur.Parent = game.Lighting

-- UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub Ultra v7",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Full System",
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

-- Speed
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

-- ================= ESP PLAYER =================
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

-- ================= FRUITS SYSTEM =================
local FruitTab = Window:CreateTab("🍏 Fruits", 4483362458)

-- Tìm trái gần nhất
local function getNearestFruit()
    local nearest, dist = nil, math.huge

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Handle") then
            local d = (v.Handle.Position - root.Position).Magnitude
            if d < dist then
                dist = d
                nearest = v.Handle
            end
        end
    end
    return nearest
end

-- Teleport
FruitTab:CreateButton({
    Name = "Teleport tới trái gần nhất",
    Callback = function()
        local fruit = getNearestFruit()
        if fruit then
            root.CFrame = fruit.CFrame + Vector3.new(0,3,0)
        end
    end
})

-- Teleport mượt
FruitTab:CreateButton({
    Name = "Teleport mượt",
    Callback = function()
        local fruit = getNearestFruit()
        if fruit then
            for i=1,10 do
                root.CFrame = root.CFrame:Lerp(fruit.CFrame,0.2)
                task.wait(0.05)
            end
        end
    end
})

-- ESP trái
local fruitESP = false
FruitTab:CreateToggle({
    Name = "ESP Fruits",
    CurrentValue = false,
    Callback = function(v)
        fruitESP = v

        while fruitESP do
            task.wait()
            for _,f in pairs(workspace:GetDescendants()) do
                if f:IsA("Model") and f:FindFirstChild("Handle") then
                    if not f:FindFirstChild("Highlight") then
                        local h = Instance.new("Highlight", f)
                        h.FillColor = Color3.fromRGB(0,255,0)
                    end
                end
            end
        end
    end
})

-- Hiện khoảng cách
FruitTab:CreateButton({
    Name = "Xem khoảng cách trái",
    Callback = function()
        local fruit = getNearestFruit()
        if fruit then
            local dist = (fruit.Position - root.Position).Magnitude
            Rayfield:Notify({
                Title = "Distance",
                Content = math.floor(dist).." studs",
                Duration = 3
            })
        end
    end
})

-- ================= TELEPORT =================
local TP = Window:CreateTab("🚀 Teleport", 4483362458)

TP:CreateButton({
    Name = "Bay lên cao",
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

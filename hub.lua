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
    Name = "Phat Hub MAX FINAL",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Ultra Pro",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhatHub",
        FileName = "Config"
    }
})

-- ANIMATION
local TweenService = game:GetService("TweenService")
task.spawn(function()
    task.wait(0.5)
    local gui = game.CoreGui:FindFirstChild("Rayfield")
    if gui then
        gui.Size = UDim2.new(0,0,0,0)
        TweenService:Create(gui, TweenInfo.new(0.5), {
            Size = UDim2.new(0,600,0,400)
        }):Play()
    end
end)

-- ================= PLAYER =================
local PlayerTab = Window:CreateTab("🧍 Player", 4483362458)

PlayerTab:CreateSlider({
    Name = "Speed",
    Range = {16,120},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        humanoid.WalkSpeed = v
    end
})

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v)
        getgenv().infJump = v
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().infJump then
        humanoid:ChangeState("Jumping")
    end
end)

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

-- ================= ESP =================
local ESP = Window:CreateTab("👁️ ESP", 4483362458)

ESP:CreateToggle({
    Name = "ESP Player",
    CurrentValue = false,
    Callback = function(v)
        while v do
            task.wait()
            for _,plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    if not plr.Character:FindFirstChild("Highlight") then
                        Instance.new("Highlight", plr.Character)
                    end
                end
            end
        end
    end
})

-- ================= FRUIT SYSTEM =================
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
    Name = "Teleport tới Fruit",
    Callback = function()
        local f = getNearestFruit()
        if f then
            root.CFrame = f.Handle.CFrame + Vector3.new(0,3,0)
        end
    end
})

FruitTab:CreateButton({
    Name = "Xem tên Fruit",
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
    Name = "ESP Fruits",
    CurrentValue = false,
    Callback = function(v)
        while v do
            task.wait()
            for _,f in pairs(workspace:GetDescendants()) do
                if f:IsA("Tool") and f:FindFirstChild("Handle") then
                    if string.find(f.Name,"Fruit") then
                        if not f:FindFirstChild("Highlight") then
                            Instance.new("Highlight", f)
                        end
                    end
                end
            end
        end
    end
})

-- ================= SHOP =================
local Shop = Window:CreateTab("🛒 Shop", 4483362458)

local fruits = {
    "Rocket Fruit","Spin Fruit","Chop Fruit","Spring Fruit",
    "Bomb Fruit","Smoke Fruit","Flame Fruit","Ice Fruit",
    "Light Fruit","Magma Fruit","Quake Fruit",
    "Dragon Fruit","Leopard Fruit"
}

for _,name in pairs(fruits) do
    Shop:CreateButton({
        Name = name,
        Callback = function()
            Rayfield:Notify({
                Title = "Shop",
                Content = name,
                Duration = 3
            })
        end
    })
end

Shop:CreateButton({
    Name = "🎲 Random Fruit",
    Callback = function()
        local pick = fruits[math.random(1,#fruits)]
        Rayfield:Notify({
            Title = "Random",
            Content = pick,
            Duration = 4
        })
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

-- Load nhân vật
repeat wait() until game.Players.LocalPlayer.Character

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub Pro v4",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Phat",
    ConfigurationSaving = {Enabled = false}
})

-- ================= FPS =================
local TabFPS = Window:CreateTab("FPS", 4483362458)

local fpsOn = false

TabFPS:CreateToggle({
    Name = "FPS Boost",
    CurrentValue = false,
    Callback = function(state)
        fpsOn = state

        if fpsOn then
            for i,v in pairs(game:GetDescendants()) do
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
local TabPlayer = Window:CreateTab("Player", 4483362458)

-- WalkSpeed Toggle
local speedOn = false

TabPlayer:CreateToggle({
    Name = "Speed x3",
    CurrentValue = false,
    Callback = function(state)
        speedOn = state

        while speedOn do
            wait()
            humanoid.WalkSpeed = 60
        end

        humanoid.WalkSpeed = 16
    end
})

-- Jump Toggle
local jumpOn = false

TabPlayer:CreateToggle({
    Name = "High Jump",
    CurrentValue = false,
    Callback = function(state)
        jumpOn = state

        while jumpOn do
            wait()
            humanoid.JumpPower = 100
        end

        humanoid.JumpPower = 50
    end
})

-- ================= FLY =================
local flyOn = false

TabPlayer:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(state)
        flyOn = state

        if flyOn then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
            bv.Parent = root

            while flyOn do
                wait()
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
            end

            bv:Destroy()
        end
    end
})

-- ================= NOCLIP =================
local noclipOn = false

TabPlayer:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(state)
        noclipOn = state

        while noclipOn do
            wait()
            for i,v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
})

-- ================= WORLD =================
local TabWorld = Window:CreateTab("World", 4483362458)

local brightOn = false

TabWorld:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(state)
        brightOn = state

        if brightOn then
            game.Lighting.Brightness = 5
            game.Lighting.ClockTime = 12
        else
            game.Lighting.Brightness = 1
        end
    end
})

-- ================= TELEPORT =================
local TabTP = Window:CreateTab("Teleport", 4483362458)

TabTP:CreateButton({
    Name = "Teleport lên cao",
    Callback = function()
        char:MoveTo(root.Position + Vector3.new(0,100,0))
    end
})

-- ================= INFO =================
local TabInfo = Window:CreateTab("Info", 4483362458)

TabInfo:CreateLabel("Phat Hub Pro v4")
TabInfo:CreateLabel("FULL TOGGLE SYSTEM")

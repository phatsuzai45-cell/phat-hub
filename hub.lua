-- FIX LOAD
repeat wait() until game.Players.LocalPlayer.Character

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Phat Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Phat",
    ConfigurationSaving = {Enabled = false}
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateButton({
    Name = "FPS BOOST",
    Callback = function()
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false
            end
        end

        game.Lighting.GlobalShadows = false

        Rayfield:Notify({
            Title = "Done",
            Content = "Đã bật FPS Boost",
            Duration = 3
        })
    end
})

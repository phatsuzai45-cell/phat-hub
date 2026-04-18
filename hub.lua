-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PhatHubUI"
gui.Parent = game.CoreGui

-- MAIN FRAME
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 0, 0, 0)
main.Position = UDim2.new(0.5, -150, 0.5, -100)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.ClipsDescendants = true

-- BO GÓC
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- SHADOW
local shadow = Instance.new("ImageLabel", main)
shadow.Size = UDim2.new(1,40,1,40)
shadow.Position = UDim2.new(0,-20,0,-20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.7

-- TITLE BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(30,30,30)

Instance.new("UICorner", top).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1,0,1,0)
title.Text = "Phat Hub App UI"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- TAB BUTTONS
local tabs = Instance.new("Frame", main)
tabs.Position = UDim2.new(0,0,0,40)
tabs.Size = UDim2.new(0,100,1,-40)
tabs.BackgroundColor3 = Color3.fromRGB(25,25,25)

local function createTabButton(name, y)
    local btn = Instance.new("TextButton", tabs)
    btn.Size = UDim2.new(1,0,0,40)
    btn.Position = UDim2.new(0,0,0,y)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    return btn
end

local homeBtn = createTabButton("Home",0)
local fruitBtn = createTabButton("Fruit",40)
local settingBtn = createTabButton("Settings",80)

-- CONTENT
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,100,0,40)
content.Size = UDim2.new(1,-100,1,-40)
content.BackgroundTransparency = 1

-- PAGES
local pages = {}

local function createPage(name)
    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1,0,1,0)
    page.Visible = false
    page.BackgroundTransparency = 1
    pages[name] = page
    return page
end

local homePage = createPage("Home")
local fruitPage = createPage("Fruit")
local settingPage = createPage("Settings")

homePage.Visible = true

-- SWITCH TAB
local function switchTab(name)
    for i,v in pairs(pages) do
        v.Visible = false
    end
    pages[name].Visible = true
end

homeBtn.MouseButton1Click:Connect(function()
    switchTab("Home")
end)

fruitBtn.MouseButton1Click:Connect(function()
    switchTab("Fruit")
end)

settingBtn.MouseButton1Click:Connect(function()
    switchTab("Settings")
end)

-- SAMPLE CONTENT
local label = Instance.new("TextLabel", homePage)
label.Size = UDim2.new(1,0,0,50)
label.Text = "Welcome to Phat Hub"
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1

-- ANIMATION OPEN
TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
    Size = UDim2.new(0,300,0,200)
}):Play()

-- DRAG UI
local dragging = false
local dragStart, startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

top.InputEnded:Connect(function(input)
    dragging = false
end)

UIS.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

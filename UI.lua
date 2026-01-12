-- ui.lua
local UI = {}

-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- 🎨 Paleta Obsidian
local Colors = {
    Background = Color3.fromRGB(14,14,18),
    Panel = Color3.fromRGB(22,22,28),
    Stroke = Color3.fromRGB(55,55,65),
    Text = Color3.fromRGB(235,235,240),
    SubText = Color3.fromRGB(170,170,180),
    Accent = Color3.fromRGB(160,120,255)
}

-- 🔧 Função para criar cantos
local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

-- 🔹 Inicializar UI
function UI:Init()
    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "ObsidianHub"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    -- Main
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.fromScale(0.45, 0.55)
    main.Position = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Colors.Background
    main.BorderSizePixel = 0
    round(main, 14)

    -- Stroke
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Colors.Stroke
    stroke.Thickness = 1

    -- TopBar
    local top = Instance.new("Frame", main)
    top.Size = UDim2.new(1, 0, 0, 50)
    top.BackgroundColor3 = Colors.Panel
    top.BorderSizePixel = 0
    round(top, 14)

    -- Título
    local title = Instance.new("TextLabel", top)
    title.Size = UDim2.fromScale(1, 1)
    title.BackgroundTransparency = 1
    title.Text = "OBSIDIAN HUB"
    title.TextColor3 = Colors.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18

    -- Tabs
    local tabs = Instance.new("Frame", main)
    tabs.Position = UDim2.new(0, 10, 0, 60)
    tabs.Size = UDim2.new(0, 140, 1, -70)
    tabs.BackgroundTransparency = 1

    -- Content
    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0, 160, 0, 60)
    content.Size = UDim2.new(1, -170, 1, -70)
    content.BackgroundColor3 = Colors.Panel
    content.BorderSizePixel = 0
    round(content, 12)

    -- Exemplo de texto no content
    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.Text = "Bem-vindo ao Obsidian Hub"
    label.TextColor3 = Colors.SubText
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
end

return UI

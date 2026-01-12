--=====================================================
--  OBSIDIAN HUB V2 | AGGRESSIVE UI FRAMEWORK
--  Style: Obsidian (Dark / Tech / Minimal)
--=====================================================

-------------------------
-- SERVICES
-------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-------------------------
-- THEME
-------------------------
local Theme = {
	Background = Color3.fromRGB(12,12,16),
	Panel = Color3.fromRGB(18,18,24),
	PanelLight = Color3.fromRGB(24,24,32),
	Stroke = Color3.fromRGB(55,55,70),
	Text = Color3.fromRGB(235,235,240),
	SubText = Color3.fromRGB(160,160,175),
	Accent = Color3.fromRGB(165,120,255)
}

-------------------------
-- STATE
-------------------------
local State = {
	CurrentTab = nil,
	RGB = true,
	Presets = {},
	Theme = "Dark"
}

-------------------------
-- GUI ROOT
-------------------------
local GUI = Instance.new("ScreenGui")
GUI.Name = "ObsidianHubV2"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

-------------------------
-- LOADING SCREEN
-------------------------
local Loading = Instance.new("Frame", GUI)
Loading.Size = UDim2.fromScale(1,1)
Loading.BackgroundColor3 = Theme.Background

local LoadLabel = Instance.new("TextLabel", Loading)
LoadLabel.Size = UDim2.fromScale(1,1)
LoadLabel.BackgroundTransparency = 1
LoadLabel.Text = "OBSIDIAN HUB V2\nINITIALIZING..."
LoadLabel.Font = Enum.Font.GothamBold
LoadLabel.TextSize = 26
LoadLabel.TextColor3 = Theme.Text

task.wait(1)
TweenService:Create(Loading, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
TweenService:Create(LoadLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
task.wait(0.5)
Loading:Destroy()

-------------------------
-- MAIN WINDOW
-------------------------
local Main = Instance.new("Frame", GUI)
Main.Size = UDim2.fromScale(0.5,0.6)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

-------------------------
-- SIDEBAR
-------------------------
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0,160,1,0)
Sidebar.BackgroundColor3 = Theme.Panel
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,14)

-------------------------
-- TITLE
-------------------------
local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.new(1,0,0,60)
Title.BackgroundTransparency = 1
Title.Text = "OBSIDIAN\nHUB"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextColor3 = Theme.Text

-------------------------
-- TAB BUTTON CONTAINER
-------------------------
local TabHolder = Instance.new("Frame", Sidebar)
TabHolder.Position = UDim2.new(0,0,0,70)
TabHolder.Size = UDim2.new(1,0,1,-80)
TabHolder.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout", TabHolder)
TabLayout.Padding = UDim.new(0,6)

-------------------------
-- CONTENT AREA
-------------------------
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0,170,0,10)
Content.Size = UDim2.new(1,-180,1,-20)
Content.BackgroundTransparency = 1

-------------------------
-- PAGES
-------------------------
local Pages = Instance.new("Folder", Content)

-------------------------
-- RGB TITLE
-------------------------
task.spawn(function()
	local h = 0
	while true do
		if State.RGB then
			h = (h + 0.0015) % 1
			Title.TextColor3 = Color3.fromHSV(h,0.6,1)
		end
		RunService.RenderStepped:Wait()
	end
end)

-------------------------
-- FUNCTIONS
-------------------------
local Tabs = {}

local function CreateTab(name,icon)
	local btn = Instance.new("TextButton", TabHolder)
	btn.Size = UDim2.new(1,-12,0,36)
	btn.BackgroundColor3 = Theme.PanelLight
	btn.Text = "   "..icon.."  "..name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Theme.Text
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	local indicator = Instance.new("Frame", btn)
	indicator.Size = UDim2.new(0,4,1,0)
	indicator.BackgroundColor3 = Theme.Accent
	indicator.Visible = false

	local page = Instance.new("ScrollingFrame", Pages)
	page.Size = UDim2.fromScale(1,1)
	page.CanvasSize = UDim2.new(0,0,0,0)
	page.ScrollBarImageTransparency = 1
	page.Visible = false

	local layout = Instance.new("UIListLayout", page)
	layout.Padding = UDim.new(0,12)

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		page.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 20)
	end)

	btn.MouseButton1Click:Connect(function()
		if State.CurrentTab then
			State.CurrentTab.Visible = false
		end
		for _,b in pairs(TabHolder:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Theme.PanelLight
				b:FindFirstChildOfClass("Frame").Visible = false
			end
		end
		btn.BackgroundColor3 = Theme.Panel
		indicator.Visible = true
		page.Visible = true
		State.CurrentTab = page
	end)

	Tabs[name] = page
	return page
end

-------------------------
-- UI ELEMENTS
-------------------------
local function Section(tab,text)
	local lbl = Instance.new("TextLabel", tab)
	lbl.Size = UDim2.new(1,-20,0,22)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 14
	lbl.TextXAlignment = Left
	lbl.TextColor3 = Theme.SubText
end

local function Button(tab,text,callback)
	local b = Instance.new("TextButton", tab)
	b.Size = UDim2.new(1,-20,0,38)
	b.BackgroundColor3 = Theme.Panel
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = Theme.Text
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	b.MouseButton1Click:Connect(function()
		if callback then callback() end
	end)
end

local function Slider(tab,text,min,max,default,callback)
	local frame = Instance.new("Frame", tab)
	frame.Size = UDim2.new(1,-20,0,54)
	frame.BackgroundColor3 = Theme.Panel
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1,-10,0,20)
	label.Position = UDim2.new(0,10,0,4)
	label.BackgroundTransparency = 1
	label.Text = text.." : "..default
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextColor3 = Theme.Text

	local bar = Instance.new("Frame", frame)
	bar.Position = UDim2.new(0,10,0,34)
	bar.Size = UDim2.new(1,-20,0,4)
	bar.BackgroundColor3 = Theme.Stroke

	local fill = Instance.new("Frame", bar)
	fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
	fill.BackgroundColor3 = Theme.Accent

	local dragging = false
	bar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	UIS.InputChanged:Connect(function(i)
		if dragging then
			local p = math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
			fill.Size = UDim2.new(p,0,1,0)
			local v = math.floor(min + (max-min)*p)
			label.Text = text.." : "..v
			if callback then callback(v) end
		end
	end)
end

-------------------------
-- CREATE TABS
-------------------------
local PlayerTab   = CreateTab("Player","👤")
local VisualTab   = CreateTab("Visual","🎨")
local TeleportTab = CreateTab("Teleport","📍")
local PresetTab   = CreateTab("Presets","💾")
local SettingsTab = CreateTab("Settings","⚙")

State.CurrentTab = PlayerTab
PlayerTab.Visible = true

-------------------------
-- PLAYER TAB
-------------------------
Section(PlayerTab,"Movement")
Slider(PlayerTab,"Speed",0,1000,16,function() end)
Slider(PlayerTab,"Fly Speed",0,1000,50,function() end)
Button(PlayerTab,"Toggle Fly",function() end)

-------------------------
-- VISUAL TAB
-------------------------
Section(VisualTab,"Camera")
Slider(VisualTab,"FOV",40,140,70,function(v)
	Camera.FieldOfView = v
end)
Button(VisualTab,"Toggle RGB Accent",function()
	State.RGB = not State.RGB
end)

-------------------------
-- TELEPORT TAB
-------------------------
Section(TeleportTab,"Coordinates")
Slider(TeleportTab,"X",-5000,5000,0,function() end)
Slider(TeleportTab,"Y",-5000,5000,10,function() end)
Slider(TeleportTab,"Z",-5000,5000,0,function() end)
Button(TeleportTab,"Teleport",function() end)

-------------------------
-- PRESETS TAB
-------------------------
Section(PresetTab,"Presets")
Button(PresetTab,"Save Preset",function()
	State.Presets["Default"] = os.time()
end)
Button(PresetTab,"Load Preset",function() end)

-------------------------
-- SETTINGS TAB
-------------------------
Section(SettingsTab,"Interface")
Button(SettingsTab,"Toggle Theme",function() end)

-------------------------
-- TOGGLE KEY
-------------------------
UIS.InputBegan:Connect(function(i,gp)
	if not gp and i.KeyCode == Enum.KeyCode.Insert then
		Main.Visible = not Main.Visible
	end
end)

-- END OF FRAMEWORK

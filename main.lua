-- main.lua

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- 🔗 MUDE PARA SEU GITHUB RAW
local BASE_URL = "https://raw.githubusercontent.com/victorbordallo2/ObsidianHub/main/"

local function loadModule(path)
	local ok, res = pcall(function()
		return loadstring(game:HttpGet(BASE_URL .. path))()
	end)
	if not ok then
		warn("[ObsidianHub] Erro em:", path)
		warn(res)
	end
	return res
end

-- carregar arquivos
local Config = loadModule("config.lua")
local UI = loadModule("ui.lua")

local Modules = {
	Fly = loadModule("modules/fly.lua"),
	Speed = loadModule("modules/speed.lua"),
	Teleport = loadModule("modules/teleport.lua")
}

-- iniciar
Config:Init()
UI:Init({
	Config = Config,
	Modules = Modules
})

-- tecla abrir / fechar
local visible = true
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Insert then
		visible = not visible
		UI:Toggle(visible)
	end
end)

print("Obsidian Hub carregado")

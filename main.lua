--[[ 
    Obsidian Hub
    Autor: victorbordallo2
    Versão: Loadstring Safe
--]]

-- ======================
-- PROTEÇÃO BÁSICA
-- ======================
print("MAIN CARREGADO COM SUCESSO")
if _G.ObsidianLoaded then
    warn("Obsidian Hub já carregado")
    return
end
_G.ObsidianLoaded = true

-- ======================
-- SERVIÇOS
-- ======================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- ======================
-- VARIÁVEIS PRINCIPAIS
-- ======================
local Settings = {
    FlySpeed = 50,
    WalkSpeed = 16,
    FlyEnabled = false
}

-- ======================
-- FUNÇÕES ÚTEIS
-- ======================
local function Notify(msg)
    print("[Obsidian Hub]: "..msg)
end

-- ======================
-- WALK SPEED
-- ======================
local function SetSpeed(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
        Notify("Speed definido para "..value)
    end
end

-- ======================
-- FLY SIMPLES
-- ======================
local FlyConnection
local BodyVelocity

local function EnableFly()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    BodyVelocity.Velocity = Vector3.zero
    BodyVelocity.Parent = char.HumanoidRootPart

    FlyConnection = RunService.RenderStepped:Connect(function()
        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= workspace.CurrentCamera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= workspace.CurrentCamera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += workspace.CurrentCamera.CFrame.RightVector end

        BodyVelocity.Velocity = moveDir * Settings.FlySpeed
    end)

    Notify("Fly ativado")
end

local function DisableFly()
    if FlyConnection then FlyConnection:Disconnect() end
    if BodyVelocity then BodyVelocity:Destroy() end
    Notify("Fly desativado")
end

-- ======================
-- TECLAS
-- ======================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.F then
        Settings.FlyEnabled = not Settings.FlyEnabled
        if Settings.FlyEnabled then
            EnableFly()
        else
            DisableFly()
        end
    end

    if input.KeyCode == Enum.KeyCode.KeypadPlus then
        Settings.FlySpeed += 10
        Notify("FlySpeed: "..Settings.FlySpeed)
    end

    if input.KeyCode == Enum.KeyCode.KeypadMinus then
        Settings.FlySpeed -= 10
        Notify("FlySpeed: "..Settings.FlySpeed)
    end
end)

-- ======================
-- AUTO APPLY SPEED
-- ======================
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    SetSpeed(Settings.WalkSpeed)
end)

-- ======================
-- START
-- ======================
Notify("Obsidian Hub carregado com sucesso")
Notify("F = Fly | + - ajusta FlySpeed")

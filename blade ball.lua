-- Script Spam Blade Ball - Botón Visual para Delta iOS
-- Autor: AI Assistant
-- Compatible con Delta, Slender, JitPack iOS

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- CONFIGURACIÓN
local SPAM_KEY = Enum.KeyCode.F       -- Tecla que spamea (F)
local CPS = 30                        -- Clicks por segundo
local INTERVAL = 1 / CPS              -- Intervalo entre clicks

-- Estado inicial
local isSpamming = false 

-- Crear un ScreenGui personalizado para el botón
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BladeBallSpamUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Crear el botón
local button = Instance.new("TextButton")
button.Name = "ToggleSpamBtn"
button.Size = UDim2.new(0, 60, 0, 40)
button.Position = UDim2.new(1, -70, 0, 10) -- Esquina superior derecha
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Rojo (OFF)
button.Text = "OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.BorderSizePixel = 2
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.Parent = screenGui

-- Función para actualizar la UI
local function updateUI()
    if isSpamming then
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Verde (ON)
        button.Text = "ON"
    else
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Rojo (OFF)
        button.Text = "OFF"
    end
end

-- Evento al tocar el botón
button.Activated:Connect(function()
    isSpamming = not isSpamming
    updateUI()
    
    -- Feedback visual rápido (opcional)
    if isSpamming then
        print("[Blade Ball] SPAM ACTIVADO")
    else
        print("[Blade Ball] SPAM DESACTIVADO")
    end
end)

-- Inicializar estado visual
updateUI()

-- Bucle principal de spam en un hilo separado
spawn(function()
    while true do
        if isSpamming then
            -- Simular pulsación de tecla F
            UserInputService:KeyDown(SPAM_KEY)
            UserInputService:KeyUp(SPAM_KEY)
            
            -- Esperar el intervalo correspondiente a los CPS
            wait(INTERVAL)
        else
            -- Esperar más tiempo cuando está apagado para ahorrar recursos
            wait(0.5)
        end
    end
end)

print("[Blade Ball] Script cargado. Usa el botón ROJO en la esquina para activar.")
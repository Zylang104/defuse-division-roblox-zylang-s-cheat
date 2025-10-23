local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local isGuiEnabled = false


local function isSpectating(player)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            return humanoid.Health == 0
        end
    end
    return false
end

local function createDisplay(player)
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui", playerGui)
    screenGui.Name = "SpectatorDisplay"

    local textLabel = Instance.new("TextLabel", screenGui)
    textLabel.Size = UDim2.new(1, 0, 0.05, 0)  -- Smaller text size
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Text = "Spectating: None"

    local function updateText()
        local spectatingPlayers = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p:FindFirstChild("Spectating") then
                table.insert(spectatingPlayers, p.Name)
            end
        end

        if #spectatingPlayers > 0 then
            textLabel.Text = "Spectating: " .. table.concat(spectatingPlayers, ", ")
        else
            textLabel.Text = "Spectating: None"
        end
    end

    local connection
    local function startUpdating()
        connection = RunService.RenderStepped:Connect(function()
            if isGuiEnabled then
                updateText()
            end
        end)
    end

    local function stopUpdating()
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end


    local function toggleGui()
        screenGui.Enabled = not screenGui.Enabled
        isGuiEnabled = screenGui.Enabled

        if isGuiEnabled then
            startUpdating()
        else
            stopUpdating()
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
            toggleGui()
        end
    end)

    startUpdating()
end


Players.PlayerAdded:Connect(function(player)
    createDisplay(player)
end)


for _, player in ipairs(Players:GetPlayers()) do
    createDisplay(player)
end

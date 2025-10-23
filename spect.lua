-- Roblox Executor Script to Display All Spectating Players with Toggle

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local isGuiEnabled = false

-- Function to check if a player is spectating
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

-- Function to create and update the display for a player
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

    -- Function to update the text label based on spectator status
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

    -- Connect to the RunService to update the display
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

    -- Toggle the GUI visibility
    local function toggleGui()
        screenGui.Enabled = not screenGui.Enabled
        isGuiEnabled = screenGui.Enabled

        if isGuiEnabled then
            startUpdating()
        else
            stopUpdating()
        end
    end

    -- Connect the INSERT key to toggle the GUI
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
            toggleGui()
        end
    end)

    -- Initialize the display
    startUpdating()
end

-- Connect to the PlayerAdded event to initialize the display for new players
Players.PlayerAdded:Connect(function(player)
    createDisplay(player)
end)

-- Initialize the display for existing players
for _, player in ipairs(Players:GetPlayers()) do
    createDisplay(player)
end

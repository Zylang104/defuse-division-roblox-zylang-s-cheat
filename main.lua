local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/refs/heads/main/source.lua'))()
local Window = Rayfield:CreateWindow({
    Name = "defuse division cheat",
    LoadingTitle = "imagine cheating 💔",
    LoadingSubtitle = "rayfield lowk goated",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "defuse"
    },
    KeySystem = false,
    KeySettings = {
        Title = "defuse division cheat",
        Subtitle = "key",
        Note = "put the key",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false, 
        Key = {"yallimmakingthisscriptfreeiamnotgoingtoputakey"} 
    }
})

local Tab = Window:CreateTab("Script", 4483362458)

local Section = Tab:CreateSection("Scripts")

local function createButton(name, scriptUrl, loadFunction)
    local Button = Tab:CreateButton({
        Name = name,
        Callback = function()
            local success, err = pcall(function()
                local script = loadstring(game:HttpGet(scriptUrl, true))()
                if loadFunction then
                    loadFunction(script)
                end
            end)
            if not success then
                warn("Error script " .. err)
            end
        end,
    })
end

createButton("ESP 1", "https://raw.githubusercontent.com/wa0101/Roblox-ESP/refs/heads/main/esp.lua")
createButton("ESP 2", "https://raw.githubusercontent.com/depthso/Roblox-Extremely-simple-esp/refs/heads/main/esp.lua")
createButton("Limb Extender", "https://raw.githubusercontent.com/AAPVdev/scripts/refs/heads/main/UI_LimbExtender.lua")
createButton("Aimbot V3", "https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua", function(script) script.Load() end)
createButton("Spect Script", "https://raw.githubusercontent.com/Zylang104/defuse-division-roblox-zylang-s-cheat/refs/heads/main/spect.lua")

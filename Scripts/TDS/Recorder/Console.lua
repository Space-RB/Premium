local function RandomString(len)
    local s = ""
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, len or 12 do
        local r = math.random(1, #chars)
        s = s .. chars:sub(r, r)
    end
    return s
end

local function protect_gui(gui)
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
    end
    if gethui then
        gui.Parent = gethui()
    else
        gui.Parent = game:GetService("CoreGui")
    end
end

local function centerText(str, totalLength)
    local strLen = #str
    if strLen >= totalLength then return str end
    local totalPadding = totalLength - strLen
    local leftPad = math.floor(totalPadding / 2)
    local rightPad = totalPadding - leftPad
    return string.rep(" ", leftPad) .. str .. string.rep(" ", rightPad)
end

local function getKeyName(keyCode)
    if not keyCode then return "LCtrl" end
    local name = keyCode.Name
    if name:sub(1, 3) == "Key" then name = name:sub(4) end
    return name:upper()
end

local cols = {
    Pri = Color3.fromRGB(18, 18, 22), Sec = Color3.fromRGB(25, 25, 32),
    Ter = Color3.fromRGB(35, 35, 45), Acc = Color3.fromRGB(138, 43, 226),
    AccD = Color3.fromRGB(100, 30, 170), AccL = Color3.fromRGB(160, 80, 255),
    Txt = Color3.fromRGB(245, 245, 250), TxtSec = Color3.fromRGB(160, 160, 175),
    TxtDim = Color3.fromRGB(100, 100, 115), Suc = Color3.fromRGB(50, 205, 50),
    Warn = Color3.fromRGB(255, 185, 50), Err = Color3.fromRGB(255, 70, 70),
    Deb = Color3.fromRGB(80, 150, 255), Sys = Color3.fromRGB(180, 130, 255),
    Glow = Color3.fromRGB(138, 43, 226), Rec = Color3.fromRGB(180, 50, 50),
    Stop = Color3.fromRGB(180, 120, 40), Save = Color3.fromRGB(50, 150, 80),
    Play = Color3.fromRGB(50, 120, 180), Drop = Color3.fromRGB(30, 30, 40)
}

local mtypes = {
    Info = { Pre = "INFO", Col = cols.TxtSec }, Warn = { Pre = "WARN", Col = cols.Warn },
    Err = { Pre = "ERROR", Col = cols.Err }, Success = { Pre = "SUCCESS", Col = cols.Suc },
    Debug = { Pre = "DEBUG", Col = cols.Deb }, System = { Pre = "SYSTEM", Col = cols.Sys },
    Place = { Pre = "PLACE", Col = Color3.fromRGB(255, 170, 50) },
    Upgrade = { Pre = "UPGRADE", Col = Color3.fromRGB(180, 100, 255) },
    Sell = { Pre = "SELL", Col = Color3.fromRGB(255, 80, 100) },
    Ability = { Pre = "ABILITY", Col = Color3.fromRGB(255, 220, 50) },
    Target = { Pre = "TARGET", Col = Color3.fromRGB(255, 100, 200) },
    Skip = { Pre = "SKIP", Col = Color3.fromRGB(100, 180, 255) }
}

local lp = game:GetService("Players").LocalPlayer
local pgui = lp:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local HS = game:GetService("HttpService")
local stTime = tick()
local messageCounter = 0
local msgQ = {}
local isBindingKey = false

getgenv().ConsoleToggleKey = getgenv().ConsoleToggleKey or Enum.KeyCode.LeftControl
_G.Webhook = getgenv().Webhook or ""

if isfolder("Space-Hub/Games/") and isfile("Space-Hub/Additional/TDS-Webhook.json") then
    local content = readfile("Space-Hub/Additional/TDS-Webhook.json")
    if content then _G.Webhook = content end
end

local cGui = Instance.new("ScreenGui")
cGui.Name = "SpaceHubConsole_" .. RandomString(8)
cGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
cGui.ResetOnSpawn = false
protect_gui(cGui)

local consoleContainer = Instance.new("Frame")
consoleContainer.Name = "MainContainer"
consoleContainer.Size = UDim2.new(0, 550, 0, 400)
consoleContainer.AnchorPoint = Vector2.new(0.5, 0.5)
consoleContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
consoleContainer.BackgroundColor3 = cols.Pri
consoleContainer.BorderSizePixel = 0
consoleContainer.ClipsDescendants = true
consoleContainer.Parent = cGui

local consoleContainerCorner = Instance.new("UICorner")
consoleContainerCorner.CornerRadius = UDim.new(0, 14)
consoleContainerCorner.Parent = consoleContainer

local consoleContainerStroke = Instance.new("UIStroke")
consoleContainerStroke.Color = cols.Acc
consoleContainerStroke.Thickness = 2
consoleContainerStroke.Transparency = 0.5
consoleContainerStroke.Parent = consoleContainer

local consoleGlow = Instance.new("ImageLabel")
consoleGlow.Name = "Glow"
consoleGlow.Size = UDim2.new(1, 60, 1, 60)
consoleGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
consoleGlow.AnchorPoint = Vector2.new(0.5, 0.5)
consoleGlow.BackgroundTransparency = 1
consoleGlow.Image = "rbxassetid://5028857084"
consoleGlow.ImageColor3 = cols.Glow
consoleGlow.ImageTransparency = 0.85
consoleGlow.ScaleType = Enum.ScaleType.Slice
consoleGlow.SliceCenter = Rect.new(24, 24, 276, 276)
consoleGlow.ZIndex = 0
consoleGlow.Parent = consoleContainer

local consoleHeader = Instance.new("Frame")
consoleHeader.Name = "HeaderFrame"
consoleHeader.Size = UDim2.new(1, 0, 0, 55)
consoleHeader.BackgroundColor3 = cols.Sec
consoleHeader.BorderSizePixel = 0
consoleHeader.Parent = consoleContainer

local consoleHeaderCorner = Instance.new("UICorner")
consoleHeaderCorner.CornerRadius = UDim.new(0, 14)
consoleHeaderCorner.Parent = consoleHeader

local consoleHeaderFix = Instance.new("Frame")
consoleHeaderFix.Size = UDim2.new(1, 0, 0, 20)
consoleHeaderFix.Position = UDim2.new(0, 0, 1, -20)
consoleHeaderFix.BackgroundColor3 = cols.Sec
consoleHeaderFix.BorderSizePixel = 0
consoleHeaderFix.Parent = consoleHeader

local consoleHeaderGradient = Instance.new("Frame")
consoleHeaderGradient.Name = "HeaderGradient"
consoleHeaderGradient.Size = UDim2.new(1, 0, 0, 3)
consoleHeaderGradient.Position = UDim2.new(0, 0, 1, 0)
consoleHeaderGradient.BorderSizePixel = 0
consoleHeaderGradient.Parent = consoleHeader

local gradientUIGradient = Instance.new("UIGradient")
gradientUIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, cols.AccD),
    ColorSequenceKeypoint.new(0.5, cols.Acc),
    ColorSequenceKeypoint.new(1, cols.AccD)
})
gradientUIGradient.Parent = consoleHeaderGradient

local consoleTitleContainer = Instance.new("Frame")
consoleTitleContainer.Name = "TitleContainer"
consoleTitleContainer.Size = UDim2.new(0.6, 0, 1, 0)
consoleTitleContainer.Position = UDim2.new(0, 15, 0, 0)
consoleTitleContainer.BackgroundTransparency = 1
consoleTitleContainer.Parent = consoleHeader

local consoleLogo = Instance.new("Frame")
consoleLogo.Name = "LogoFrame"
consoleLogo.Size = UDim2.new(0, 36, 0, 36)
consoleLogo.Position = UDim2.new(0, 0, 0.5, -18)
consoleLogo.BackgroundColor3 = cols.Acc
consoleLogo.Parent = consoleTitleContainer

local consoleLogoCorner = Instance.new("UICorner")
consoleLogoCorner.CornerRadius = UDim.new(0, 10)
consoleLogoCorner.Parent = consoleLogo

local consoleLogoGradient = Instance.new("UIGradient")
consoleLogoGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, cols.AccL),
    ColorSequenceKeypoint.new(1, cols.AccD)
})
consoleLogoGradient.Rotation = 45
consoleLogoGradient.Parent = consoleLogo

local consoleLogoText = Instance.new("TextLabel")
consoleLogoText.Name = "LogoText"
consoleLogoText.Size = UDim2.new(1, 0, 1, 0)
consoleLogoText.BackgroundTransparency = 1
consoleLogoText.Text = "S"
consoleLogoText.TextColor3 = cols.Txt
consoleLogoText.TextSize = 20
consoleLogoText.Font = Enum.Font.GothamBold
consoleLogoText.Parent = consoleLogo

local consoleTitleLabel = Instance.new("TextLabel")
consoleTitleLabel.Name = "TitleLabel"
consoleTitleLabel.Size = UDim2.new(1, -50, 1, 0)
consoleTitleLabel.Position = UDim2.new(0, 48, 0, 0)
consoleTitleLabel.BackgroundTransparency = 1
consoleTitleLabel.Text = "SPACE HUB CONSOLE"
consoleTitleLabel.TextColor3 = cols.Txt
consoleTitleLabel.TextSize = 22
consoleTitleLabel.Font = Enum.Font.GothamBold
consoleTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
consoleTitleLabel.Parent = consoleTitleContainer

local consoleStatsContainer = Instance.new("Frame")
consoleStatsContainer.Name = "StatsContainer"
consoleStatsContainer.Size = UDim2.new(0, 150, 1, 0)
consoleStatsContainer.Position = UDim2.new(1, -165, 0, 0)
consoleStatsContainer.BackgroundTransparency = 1
consoleStatsContainer.Parent = consoleHeader

local runtimeLabel = Instance.new("TextLabel")
runtimeLabel.Name = "RuntimeLabel"
runtimeLabel.Size = UDim2.new(1, 0, 0.5, 0)
runtimeLabel.Position = UDim2.new(0, 0, 0, 5)
runtimeLabel.BackgroundTransparency = 1
runtimeLabel.Text = "00:00:00"
runtimeLabel.TextColor3 = cols.TxtSec
runtimeLabel.TextSize = 14
runtimeLabel.Font = Enum.Font.GothamMedium
runtimeLabel.TextXAlignment = Enum.TextXAlignment.Right
runtimeLabel.Parent = consoleStatsContainer

local timeLabel = Instance.new("TextLabel")
timeLabel.Name = "TimeLabel"
timeLabel.Size = UDim2.new(1, 0, 0.5, 0)
timeLabel.Position = UDim2.new(0, 0, 0.5, -5)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = os.date("%H:%M:%S")
timeLabel.TextColor3 = cols.TxtDim
timeLabel.TextSize = 13
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextXAlignment = Enum.TextXAlignment.Right
timeLabel.Parent = consoleStatsContainer

local consoleOutput = Instance.new("ScrollingFrame")
consoleOutput.Name = "ConsoleOutput"
consoleOutput.Size = UDim2.new(1, -24, 0, 200)
consoleOutput.Position = UDim2.new(0, 12, 0, 68)
consoleOutput.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
consoleOutput.BorderSizePixel = 0
consoleOutput.ScrollBarThickness = 6
consoleOutput.ScrollingDirection = Enum.ScrollingDirection.Y
consoleOutput.VerticalScrollBarInset = Enum.ScrollBarInset.Always
consoleOutput.ScrollBarImageColor3 = cols.Acc
consoleOutput.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleOutput.Parent = consoleContainer

local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 10)
outputCorner.Parent = consoleOutput

local outputStroke = Instance.new("UIStroke")
outputStroke.Color = cols.Ter
outputStroke.Thickness = 1
outputStroke.Parent = consoleOutput

local outputLayout = Instance.new("UIListLayout")
outputLayout.Name = "OutputLayout"
outputLayout.Padding = UDim.new(0, 3)
outputLayout.SortOrder = Enum.SortOrder.LayoutOrder
outputLayout.Parent = consoleOutput

local outputPadding = Instance.new("UIPadding")
outputPadding.Name = "OutputPadding"
outputPadding.PaddingTop = UDim.new(0, 10)
outputPadding.PaddingLeft = UDim.new(0, 12)
outputPadding.PaddingRight = UDim.new(0, 12)
outputPadding.PaddingBottom = UDim.new(0, 10)
outputPadding.Parent = consoleOutput

local consoleControls = Instance.new("Frame")
consoleControls.Name = "ConsoleControls"
consoleControls.Size = UDim2.new(1, -24, 0, 36)
consoleControls.Position = UDim2.new(0, 12, 0, 275)
consoleControls.BackgroundTransparency = 1
consoleControls.Parent = consoleContainer

local buttonGap = 8

local bindButton = Instance.new("TextButton")
bindButton.Name = "BindBtn"
bindButton.Size = UDim2.new(0.33, -buttonGap, 1, 0)
bindButton.Position = UDim2.new(0, 0, 0, 0)
bindButton.BackgroundColor3 = cols.Ter
bindButton.Text = "[ " .. getKeyName(getgenv().ConsoleToggleKey) .. " ]"
bindButton.TextColor3 = cols.Acc
bindButton.TextSize = 14
bindButton.Font = Enum.Font.GothamBold
bindButton.Parent = consoleControls

local bindCorner = Instance.new("UICorner")
bindCorner.CornerRadius = UDim.new(0, 8)
bindCorner.Parent = bindButton

local bindStroke = Instance.new("UIStroke")
bindStroke.Color = cols.Acc
bindStroke.Thickness = 1
bindStroke.Transparency = 0.5
bindStroke.Parent = bindButton

local clearButton = Instance.new("TextButton")
clearButton.Name = "ClearBtn"
clearButton.Size = UDim2.new(0.33, -buttonGap, 1, 0)
clearButton.Position = UDim2.new(0.33, buttonGap/2, 0, 0)
clearButton.BackgroundColor3 = cols.Sec
clearButton.Text = "CLEAR"
clearButton.TextColor3 = cols.Txt
clearButton.TextSize = 14
clearButton.Font = Enum.Font.GothamBold
clearButton.Parent = consoleControls

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = clearButton

local hideButton = Instance.new("TextButton")
hideButton.Name = "HideBtn"
hideButton.Size = UDim2.new(0.33, -buttonGap, 1, 0)
hideButton.Position = UDim2.new(1-0.325, buttonGap/2, 0, 0)
hideButton.BackgroundColor3 = cols.Err
hideButton.Text = "HIDE"
hideButton.TextColor3 = cols.Txt
hideButton.TextSize = 14
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = consoleControls

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 8)
hideCorner.Parent = hideButton

local webhookSection = Instance.new("Frame")
webhookSection.Name = "WebhookSection"
webhookSection.Size = UDim2.new(1, -24, 0, 68)
webhookSection.Position = UDim2.new(0, 12, 0, 320)
webhookSection.BackgroundColor3 = cols.Sec
webhookSection.BorderSizePixel = 0
webhookSection.Parent = consoleContainer

local webhookCorner = Instance.new("UICorner")
webhookCorner.CornerRadius = UDim.new(0, 10)
webhookCorner.Parent = webhookSection

local webhookHeader = Instance.new("TextLabel")
webhookHeader.Name = "WebhookHeader"
webhookHeader.Size = UDim2.new(1, -20, 0, 22)
webhookHeader.Position = UDim2.new(0, 12, 0, 5)
webhookHeader.BackgroundTransparency = 1
webhookHeader.Text = "DISCORD WEBHOOK"
webhookHeader.TextColor3 = cols.Txt
webhookHeader.TextSize = 12
webhookHeader.Font = Enum.Font.GothamBold
webhookHeader.TextXAlignment = Enum.TextXAlignment.Left
webhookHeader.Parent = webhookSection

local webhookInputContainer = Instance.new("Frame")
webhookInputContainer.Name = "WebhookInputContainer"
webhookInputContainer.Size = UDim2.new(0.62, 0, 0, 32)
webhookInputContainer.Position = UDim2.new(0, 12, 0, 30)
webhookInputContainer.BackgroundColor3 = cols.Pri
webhookInputContainer.BorderSizePixel = 0
webhookInputContainer.Parent = webhookSection

local inputCornerWebhook = Instance.new("UICorner")
inputCornerWebhook.CornerRadius = UDim.new(0, 8)
inputCornerWebhook.Parent = webhookInputContainer

local webhookBox = Instance.new("TextBox")
webhookBox.Name = "WebhookBox"
webhookBox.Size = UDim2.new(1, -16, 1, 0)
webhookBox.Position = UDim2.new(0, 8, 0, 0)
webhookBox.BackgroundTransparency = 1
webhookBox.TextColor3 = cols.Txt
webhookBox.TextSize = 11
webhookBox.Font = Enum.Font.Gotham
webhookBox.PlaceholderText = "https://discord.com/api/webhooks/..."
webhookBox.Text = _G.Webhook
webhookBox.PlaceholderColor3 = cols.TxtDim
webhookBox.ClearTextOnFocus = false
webhookBox.TextXAlignment = Enum.TextXAlignment.Left
webhookBox.Parent = webhookInputContainer
webhookBox.TextWrapped = true
webhookBox.TextScaled = true

local webhookButtonsContainer = Instance.new("Frame")
webhookButtonsContainer.Name = "WebhookButtons"
webhookButtonsContainer.Size = UDim2.new(0.35, -12, 0, 32)
webhookButtonsContainer.Position = UDim2.new(0.65, 0, 0, 30)
webhookButtonsContainer.BackgroundTransparency = 1
webhookButtonsContainer.Parent = webhookSection

local saveWebhookBtn = Instance.new("TextButton")
saveWebhookBtn.Name = "SaveWebhookBtn"
saveWebhookBtn.Size = UDim2.new(0.32, 0, 1, 0)
saveWebhookBtn.Position = UDim2.new(0, 0, 0, 0)
saveWebhookBtn.BackgroundColor3 = cols.Acc
saveWebhookBtn.Text = "SAVE"
saveWebhookBtn.TextColor3 = cols.Txt
saveWebhookBtn.TextSize = 11
saveWebhookBtn.Font = Enum.Font.GothamBold
saveWebhookBtn.Parent = webhookButtonsContainer

local saveWebhookCorner = Instance.new("UICorner")
saveWebhookCorner.CornerRadius = UDim.new(0, 6)
saveWebhookCorner.Parent = saveWebhookBtn

local testWebhookBtn = Instance.new("TextButton")
testWebhookBtn.Name = "TestWebhookBtn"
testWebhookBtn.Size = UDim2.new(0.32, 0, 1, 0)
testWebhookBtn.Position = UDim2.new(0.34, 0, 0, 0)
testWebhookBtn.BackgroundColor3 = cols.Deb
testWebhookBtn.Text = "TEST"
testWebhookBtn.TextColor3 = cols.Txt
testWebhookBtn.TextSize = 11
testWebhookBtn.Font = Enum.Font.GothamBold
testWebhookBtn.Parent = webhookButtonsContainer

local testWebhookCorner = Instance.new("UICorner")
testWebhookCorner.CornerRadius = UDim.new(0, 6)
testWebhookCorner.Parent = testWebhookBtn

local sendWebhookBtn = Instance.new("TextButton")
sendWebhookBtn.Name = "SendWebhookBtn"
sendWebhookBtn.Size = UDim2.new(0.32, 0, 1, 0)
sendWebhookBtn.Position = UDim2.new(0.68, 0, 0, 0)
sendWebhookBtn.BackgroundColor3 = cols.Sys
sendWebhookBtn.Text = "SEND"
sendWebhookBtn.TextColor3 = cols.Txt
sendWebhookBtn.TextSize = 11
sendWebhookBtn.Font = Enum.Font.GothamBold
sendWebhookBtn.Parent = webhookButtonsContainer

local sendWebhookCorner = Instance.new("UICorner")
sendWebhookCorner.CornerRadius = UDim.new(0, 6)
sendWebhookCorner.Parent = sendWebhookBtn

local function updateCanvasSize()
    local totalHeight = 0
    for _, child in ipairs(consoleOutput:GetChildren()) do
        if child:IsA("TextLabel") then totalHeight = totalHeight + child.AbsoluteSize.Y + 3 end
    end
    consoleOutput.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
end

local function processConsoleMessage(text, messageType)
    messageType = messageType or "Info"
    messageCounter = messageCounter + 1
    local messageConfig = mtypes[messageType] or mtypes.Info
    local timestamp = os.date("%H:%M:%S")
    local centeredPrefix = centerText(messageConfig.Pre, 10)
    local fullText = "[" .. timestamp .. "] - [" .. centeredPrefix .. "]: " .. tostring(text)
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Msg_" .. messageCounter
    messageLabel.Size = UDim2.new(1, -10, 0, 16)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = fullText
    messageLabel.TextColor3 = messageConfig.Col
    messageLabel.TextSize = 12
    messageLabel.Font = Enum.Font.Code
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.LayoutOrder = messageCounter
    messageLabel.Parent = consoleOutput
    task.defer(function()
        updateCanvasSize()
        consoleOutput.CanvasPosition = Vector2.new(0, consoleOutput.CanvasSize.Y.Offset)
    end)
end

local function printToConsole(text, messageType)
    table.insert(msgQ, {text = text, messageType = messageType})
end

local function clearConsole()
    for _, child in ipairs(consoleOutput:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    messageCounter = 0
    consoleOutput.CanvasSize = UDim2.new(0, 0, 0, 0)
    table.insert(msgQ, {text = "Console cleared", messageType = "System"})
end

local function toNumber(text)
    if type(text) ~= "string" then text = tostring(text) end
    local numbers = {}
    for number in text:gmatch("-?%d+%.?%d*") do table.insert(numbers, tonumber(number)) end
    return numbers[1] or 0
end

getgenv().RewarmA = 0

local function sendWebhook()
    local webhook = _G.Webhook
    if webhook == "" or not webhook then printToConsole("Webhook URL is empty", "Error") return false end
    if not string.find(webhook, "https://discord.com/api/webhooks/") then printToConsole("Invalid webhook URL format", "Error") return false end
    local playerName = lp.Name
    local xprewardText = pgui.ReactGameNewRewards.Frame.gameOver.RewardsScreen.RewardsSection["1"].icon.icon.textLabel.Text
    local rewardText = pgui.ReactGameNewRewards.Frame.gameOver.RewardsScreen.RewardsSection["2"].icon.icon.textLabel.Text
    local rewardAAmount = toNumber(rewardText)
    local rewardBAmount = toNumber(xprewardText)
    getgenv().RewarmA = rewardAAmount or "N/A - Report this bug"
    getgenv().RewarmB = rewardBAmount or "N/A - Report this bug"
    local runTimeSeconds = tick() - stTime
    local runTime = string.format("%02d:%02d:%02d", math.floor(runTimeSeconds / 3600), math.floor((runTimeSeconds % 3600) / 60), math.floor(runTimeSeconds % 60))
    local embed = {
        title = "⭐Space Hub - Macro Recorder", color = 0x8B00FF,
        fields = {
            {name = "👤Player", value = "```" .. playerName .. "```", inline = false},
            {name = "🌌Received Value", value = "```" .. tostring(getgenv().RewarmA) .. "```", inline = true},
            {name = "🌌XP Gained", value = "```" .. tostring(getgenv().RewarmB) .. "```", inline = true},
            {name = "", inline = false},
            {name = "Run Time", value = runTime, inline = true},
            {name = "Local Time", value = os.date("%H:%M:%S"), inline = true}
        }, footer = {text = "TDS Recorder | .gg/spacerb"}, timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    local success, jsonData = pcall(HS.JSONEncode, HS, { username = ".gg/spacerb", embeds = {embed} })
    if not success then printToConsole("JSON encoding failed", "Error") return false end
    local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request
    if not httpRequest then printToConsole("HTTP request not available", "Error") return false end
    local reqSuccess, response = pcall(httpRequest, { Url = webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData })
    if reqSuccess and response and (response.StatusCode == 204 or response.StatusCode == 200) then printToConsole("Webhook sent successfully!", "Success") return true
    else printToConsole("Webhook failed", "Error") return false end
end

local function testWebhook()
    local webhook = _G.Webhook
    if webhook == "" or not webhook then printToConsole("Webhook URL is empty", "Error") return false end
    local originalText = testWebhookBtn.Text
    testWebhookBtn.Text = "..."
    local success, jsonData = pcall(HS.JSONEncode, HS, { content = "Webhook Test - Space Hub Console", username = "Space Hub Console", embeds = {{ title = "Test Message", description = "Webhook is working!", color = 0x8B00FF, footer = {text = "Space Hub"}, timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") }} })
    if not success then testWebhookBtn.Text = originalText printToConsole("JSON encoding failed", "Error") return false end
    local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request
    if not httpRequest then testWebhookBtn.Text = originalText printToConsole("HTTP request not available", "Error") return false end
    local reqSuccess, response = pcall(httpRequest, { Url = webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonData })
    if reqSuccess and response and (response.StatusCode == 204 or response.StatusCode == 200) then testWebhookBtn.Text = "✓" printToConsole("Webhook test successful!", "Success") task.delay(1.5, function() testWebhookBtn.Text = originalText end) return true
    else testWebhookBtn.Text = "✗" printToConsole("Webhook test failed", "Error") task.delay(1.5, function() testWebhookBtn.Text = originalText end) return false end
end

clearButton.MouseButton1Click:Connect(clearConsole)

bindButton.MouseButton1Click:Connect(function()
    if isBindingKey then return end
    isBindingKey = true
    bindButton.Text = "[ ... ]"
    bindButton.TextColor3 = cols.Warn
end)

saveWebhookBtn.MouseButton1Click:Connect(function()
    _G.Webhook = webhookBox.Text
    makefolder("Space-Hub"); makefolder("Space-Hub/Games"); makefolder("Space-Hub/Additional")
    writefile("Space-Hub/Additional/TDS-Webhook.json", _G.Webhook)
    printToConsole("Webhook URL saved", "Success")
end)

testWebhookBtn.MouseButton1Click:Connect(testWebhook)
sendWebhookBtn.MouseButton1Click:Connect(sendWebhook)

webhookBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then _G.Webhook = webhookBox.Text printToConsole("Webhook URL saved", "Success") end
end)

local consoleDragging = false
local consoleDragStartX, consoleDragStartY
local consoleDragStartPosX, consoleDragStartPosY

consoleHeader.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        consoleDragging = true
        consoleDragStartX = input.Position.X; consoleDragStartY = input.Position.Y
        consoleDragStartPosX = consoleContainer.Position.X.Offset; consoleDragStartPosY = consoleContainer.Position.Y.Offset
        local connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then consoleDragging = false if connection then connection:Disconnect() end end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if consoleDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local deltaX = input.Position.X - consoleDragStartX; local deltaY = input.Position.Y - consoleDragStartY
        consoleContainer.Position = UDim2.new(0.5, consoleDragStartPosX + deltaX, 0.5, consoleDragStartPosY + deltaY)
    end
end)

task.spawn(function()
    while cGui.Parent do
        local elapsed = tick() - stTime
        local hours = math.floor(elapsed / 3600); local minutes = math.floor((elapsed % 3600) / 60); local seconds = math.floor(elapsed % 60)
        runtimeLabel.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
        timeLabel.Text = os.date("%H:%M:%S")
        task.wait(1)
    end
end)

task.spawn(function()
    while cGui.Parent do
        if #msgQ > 0 then
            local msg = table.remove(msgQ, 1)
            pcall(function() processConsoleMessage(msg.text, msg.messageType) end)
        end
        task.wait(0.05)
    end
end)

task.spawn(function()
    local Workspace = game:GetService("Workspace")
    while true do
        if Workspace.Music.Value == "Lose" or Workspace.Triumph.Value == true then
            pcall(sendWebhook)
            break
        end
        task.wait(0.5)
    end
end)

printToConsole("Space Hub Console initialized", "System")
printToConsole("Press [ " .. getKeyName(getgenv().ConsoleToggleKey) .. " ] to toggle GUI", "Info")

hideButton.MouseButton1Click:Connect(function()
    cGui.Enabled = false
    if _G.RecorderGui then _G.RecorderGui.Enabled = false end
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if isBindingKey and input.UserInputType == Enum.UserInputType.Keyboard then
        isBindingKey = false
        getgenv().ConsoleToggleKey = input.KeyCode
        bindButton.Text = "[ " .. getKeyName(input.KeyCode) .. " ]"
        bindButton.TextColor3 = cols.Acc
        return
    end
    if input.KeyCode == getgenv().ConsoleToggleKey then
        local newState = not cGui.Enabled
        cGui.Enabled = newState
        if _G.RecorderGui then _G.RecorderGui.Enabled = newState end
    end
end)

_G.print = function(text, messageType)
    pcall(function()
        printToConsole(text, messageType or "Info")
    end)
end

_G.clear = clearConsole

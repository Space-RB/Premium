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

local cGui = Instance.new("ScreenGui")
cGui.Name = "SpaceHubConsole_" .. RandomString(8)
cGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
cGui.ResetOnSpawn = false
protect_gui(cGui)

local consoleContainer = Instance.new("Frame")
consoleContainer.Name = "MainContainer"
consoleContainer.Size = UDim2.new(0, 550, 0, 325)
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
bindButton.Size = UDim2.new(0.5, -buttonGap/2, 1, 0)
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
clearButton.Size = UDim2.new(0.5, -buttonGap/2, 1, 0)
clearButton.Position = UDim2.new(0.5, buttonGap/2, 0, 0)
clearButton.BackgroundColor3 = cols.Sec
clearButton.Text = "CLEAR"
clearButton.TextColor3 = cols.Txt
clearButton.TextSize = 14
clearButton.Font = Enum.Font.GothamBold
clearButton.Parent = consoleControls

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = clearButton

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

clearButton.MouseButton1Click:Connect(clearConsole)

bindButton.MouseButton1Click:Connect(function()
    if isBindingKey then return end
    isBindingKey = true
    bindButton.Text = "[ ... ]"
    bindButton.TextColor3 = cols.Warn
end)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
    local delta = input.Position - dragStart
    consoleContainer.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

consoleHeader.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = consoleContainer.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                dragInput = nil
            end
        end)
    end
end)

consoleHeader.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
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

printToConsole("Space Hub Console initialized", "System")
printToConsole("Press [ " .. getKeyName(getgenv().ConsoleToggleKey) .. " ] to toggle GUI", "Info")

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
        cGui.Enabled = not cGui.Enabled
        if _G.RecorderGui then _G.RecorderGui.Enabled = cGui.Enabled end
    end
end)

_G.print = function(text, messageType)
    pcall(function()
        printToConsole(text, messageType or "Info")
    end)
end

_G.clear = clearConsole

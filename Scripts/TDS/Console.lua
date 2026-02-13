-- [[ OUTDATED 20.01.2026 11:48 PM ]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

getgenv().Webhook = getgenv().Webhook or ""

local function protect_gui(gui)
    gui.Parent = CoreGui
end

local function RandomString(len)
    local s = ""
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i = 1, len or 12 do
        local r = math.random(1, #chars)
        s = s .. chars:sub(r, r)
    end
    return s
end

local _G = _G or getfenv()
local _E = _E or {}
_E.RS = RandomString

local consoleGUI = Instance.new("ScreenGui")
consoleGUI.Name = "ConsoleGUI_" .. _E.RS(8)
consoleGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
protect_gui(consoleGUI)

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame_" .. _E.RS(8)
mainFrame.Size = UDim2.new(0, 600, 0, 450)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = consoleGUI

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 8)
UICorner1.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar_" .. _E.RS(7)
titleBar.Size = UDim2.new(1, 0, 0.07, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel_" .. _E.RS(6)
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.Position = UDim2.new(0.05, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Roblox Console"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local runtimeLabel = Instance.new("TextLabel")
runtimeLabel.Name = "RuntimeLabel_" .. _E.RS(6)
runtimeLabel.Size = UDim2.new(0.1, 0, 1, 0)
runtimeLabel.Position = UDim2.new(0.75, 0, 0, 0)
runtimeLabel.BackgroundTransparency = 1
runtimeLabel.Text = "00:00"
runtimeLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
runtimeLabel.TextScaled = true
runtimeLabel.Font = Enum.Font.Gotham
runtimeLabel.TextXAlignment = Enum.TextXAlignment.Right
runtimeLabel.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeBtn_" .. _E.RS(9)
minimizeButton.Size = UDim2.new(0.06, 0, 0.6, 0)
minimizeButton.Position = UDim2.new(0.85, 0, 0.2, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
minimizeButton.TextScaled = true
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

--[[local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseBtn_" .. _E.RS(9)
closeButton.Size = UDim2.new(0.06, 0, 0.6, 0)
closeButton.Position = UDim2.new(0.92, 0, 0.2, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
closeButton.TextScaled = true
closeButton.Parent = titleBar]]

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 4)
UICorner3.Parent = minimizeButton

--[[local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 4)
UICorner4.Parent = closeButton]]

local outputFrame = Instance.new("ScrollingFrame")
outputFrame.Name = "OutputFrame_" .. _E.RS(11)
outputFrame.Size = UDim2.new(1, -10, 0.78, -5)
outputFrame.Position = UDim2.new(0, 5, 0.07, 0)
outputFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
outputFrame.BorderSizePixel = 0
outputFrame.ScrollBarThickness = 8
outputFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
outputFrame.ScrollingDirection = Enum.ScrollingDirection.Y
outputFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
outputFrame.Parent = mainFrame

local UICorner5 = Instance.new("UICorner")
UICorner5.CornerRadius = UDim.new(0, 6)
UICorner5.Parent = outputFrame

local outputLayout = Instance.new("UIListLayout")
outputLayout.Name = "OutputLayout_" .. _E.RS(12)
outputLayout.Padding = UDim.new(0, 3)
outputLayout.SortOrder = Enum.SortOrder.LayoutOrder
outputLayout.Parent = outputFrame

local outputPadding = Instance.new("UIPadding")
outputPadding.Name = "OutputPadding_" .. _E.RS(13)
outputPadding.PaddingTop = UDim.new(0, 5)
outputPadding.PaddingLeft = UDim.new(0, 8)
outputPadding.PaddingRight = UDim.new(0, 8)
outputPadding.PaddingBottom = UDim.new(0, 8)
outputPadding.Parent = outputFrame

local webhookFrame = Instance.new("Frame")
webhookFrame.Name = "WebhookFrame_" .. _E.RS(16)
webhookFrame.Size = UDim2.new(0.35, 0, 0.1, 0)
webhookFrame.Position = UDim2.new(0.63, 0, 0.85, 0)
webhookFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
webhookFrame.BorderSizePixel = 0
webhookFrame.Parent = mainFrame

local webhookCorner = Instance.new("UICorner")
webhookCorner.CornerRadius = UDim.new(0, 6)
webhookCorner.Parent = webhookFrame

local webhookLabel = Instance.new("TextLabel")
webhookLabel.Name = "WebhookLabel_" .. _E.RS(17)
webhookLabel.Size = UDim2.new(1, -10, 0.3, 0)
webhookLabel.Position = UDim2.new(0, 5, 0, 0)
webhookLabel.BackgroundTransparency = 1
webhookLabel.Text = "Webhook:"
webhookLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
webhookLabel.TextSize = 12
webhookLabel.TextXAlignment = Enum.TextXAlignment.Left
webhookLabel.Font = Enum.Font.GothamBold
webhookLabel.Parent = webhookFrame

local webhookBox = Instance.new("TextBox")
webhookBox.Name = "WebhookBox_" .. _E.RS(18)
webhookBox.Size = UDim2.new(1, -10, 0.3, 0)
webhookBox.Position = UDim2.new(0, 5, 0.3, 0)
webhookBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
webhookBox.TextColor3 = Color3.fromRGB(220, 220, 220)
webhookBox.TextSize = 10
webhookBox.Font = Enum.Font.Gotham
webhookBox.PlaceholderText = "https://discord.com/api/webhooks/..."
webhookBox.Text = getgenv().Webhook
webhookBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
webhookBox.ClearTextOnFocus = false
webhookBox.ClipsDescendants = true
webhookBox.TextXAlignment = Enum.TextXAlignment.Left
webhookBox.Parent = webhookFrame

local webhookPadding = Instance.new("UIPadding")
webhookPadding.Name = "WebhookPadding_" .. _E.RS(19)
webhookPadding.PaddingLeft = UDim.new(0, 5)
webhookPadding.PaddingRight = UDim.new(0, 5)
webhookPadding.Parent = webhookBox

local webhookCorner2 = Instance.new("UICorner")
webhookCorner2.CornerRadius = UDim.new(0, 3)
webhookCorner2.Parent = webhookBox

local buttonsFrame = Instance.new("Frame")
buttonsFrame.Name = "ButtonsFrame_" .. _E.RS(22)
buttonsFrame.Size = UDim2.new(1, -10, 0.3, 0)
buttonsFrame.Position = UDim2.new(0, 5, 0.65, 0)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = webhookFrame

local buttonsLayout = Instance.new("UIListLayout")
buttonsLayout.Name = "ButtonsLayout_" .. _E.RS(23)
buttonsLayout.FillDirection = Enum.FillDirection.Horizontal
buttonsLayout.Padding = UDim.new(0, 3)
buttonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
buttonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonsLayout.Parent = buttonsFrame

local saveButton = Instance.new("TextButton")
saveButton.Name = "SaveBtn_" .. _E.RS(20)
saveButton.Size = UDim2.new(0.3, 0, 1, 0)
saveButton.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
saveButton.Text = "Save"
saveButton.TextColor3 = Color3.fromRGB(220, 220, 220)
saveButton.TextSize = 11
saveButton.Font = Enum.Font.GothamBold
saveButton.LayoutOrder = 1
saveButton.Parent = buttonsFrame

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 3)
saveCorner.Parent = saveButton

local testButton = Instance.new("TextButton")
testButton.Name = "TestBtn_" .. _E.RS(21)
testButton.Size = UDim2.new(0.3, 0, 1, 0)
testButton.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
testButton.Text = "Test"
testButton.TextColor3 = Color3.fromRGB(220, 220, 220)
testButton.TextSize = 11
testButton.Font = Enum.Font.GothamBold
testButton.LayoutOrder = 2
testButton.Parent = buttonsFrame

local testCorner = Instance.new("UICorner")
testCorner.CornerRadius = UDim.new(0, 3)
testCorner.Parent = testButton

local sendButton = Instance.new("TextButton")
sendButton.Name = "SendBtn_" .. _E.RS(24)
sendButton.Size = UDim2.new(0.35, 0, 1, 0)
sendButton.BackgroundColor3 = Color3.fromRGB(100, 60, 150)
sendButton.Text = "Send"
sendButton.TextColor3 = Color3.fromRGB(220, 220, 220)
sendButton.TextSize = 11
sendButton.Font = Enum.Font.GothamBold
sendButton.LayoutOrder = 3
sendButton.Parent = buttonsFrame

local sendCorner = Instance.new("UICorner")
sendCorner.CornerRadius = UDim.new(0, 3)
sendCorner.Parent = sendButton

local clearButton = Instance.new("TextButton")
clearButton.Name = "ClearBtn_" .. _E.RS(14)
clearButton.Size = UDim2.new(0.12, 0, 0.06, 0)
clearButton.Position = UDim2.new(0.02, 0, 0.92, 0)
clearButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
clearButton.Text = "Clear"
clearButton.TextColor3 = Color3.fromRGB(220, 220, 220)
clearButton.TextSize = 14
clearButton.Font = Enum.Font.GothamBold
clearButton.Parent = mainFrame

local UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 4)
UICorner6.Parent = clearButton

local resizeHandle = Instance.new("Frame")
resizeHandle.Name = "ResizeHandle_" .. _E.RS(15)
resizeHandle.Size = UDim2.new(0, 16, 0, 16)
resizeHandle.Position = UDim2.new(1, -16, 1, -16)
resizeHandle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
resizeHandle.BorderSizePixel = 1
resizeHandle.BorderColor3 = Color3.fromRGB(120, 120, 120)
resizeHandle.ZIndex = 2
resizeHandle.Parent = mainFrame

local resizeCorner = Instance.new("UICorner")
resizeCorner.CornerRadius = UDim.new(0, 3)
resizeCorner.Parent = resizeHandle

local function getMessageType(messageType)
    local types = {
        info = "[INFO]",
        warning = "[WARN]",
        error = "[ERROR]",
        success = "[SUCCESS]",
        debug = "[DEBUG]",
        system = "[SYSTEM]"
    }
    return types[messageType] or "[INFO]"
end

local function getMessageColor(messageType)
    local colors = {
        info = Color3.fromRGB(220, 220, 220),
        warning = Color3.fromRGB(255, 200, 0),
        error = Color3.fromRGB(255, 60, 60),
        success = Color3.fromRGB(60, 255, 60),
        debug = Color3.fromRGB(100, 150, 255),
        system = Color3.fromRGB(150, 100, 255)
    }
    return colors[messageType] or colors.info
end

local startTime = tick()

function _E.sendWebhook()
    local webhook = getgenv().Webhook
    if webhook == "" or webhook == nil then
        _E.printToConsole("Webhook URL is empty", "error")
        return false
    end
    
    if not string.find(webhook, "https://discord.com/api/webhooks/") then
        _E.printToConsole("Invalid webhook URL format", "error")
        return false
    end
    
    local currentMoney = game:GetService("Players").LocalPlayer.Coins.Value or 0
    local playerName = player.Name
    
    getgenv().RewarmA = getgenv().RewarmA or 0
    
    local runTimeSeconds = tick() - startTime
    local runHours = math.floor(runTimeSeconds / 3600)
    local runMinutes = math.floor((runTimeSeconds % 3600) / 60)
    local runSeconds = math.floor(runTimeSeconds % 60)
    local runTime = string.format("%02d:%02d:%02d", runHours, runMinutes, runSeconds)
    
    local embed = {
        title = "💰 money - TDS",
        color = 0x8B00FF,
        fields = {
            {
                name = "👤 Player:",
                value = "```" .. tostring(playerName) .. "```",
                inline = false
            },
            {
                name = "💰 Current money:",
                value = "```" .. tostring(currentMoney) .. "```",
                inline = true
            },
            {
                name = "⭐ Total Received:",
                value = "```" .. tostring(getgenv().RewarmA) .. "```",
                inline = true
            },
            {
                name = "⏰ Local Time",
                value = "```" .. os.date("%H:%M:%S") .. "```",
                inline = true
            },
            {
                name = "🕐 Run Time",
                value = "```" .. tostring(runTime) .. "```",
                inline = true
            }
        },
        footer = {
            text = "TDS Farmer • " .. os.date("%d.%m.%Y")
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    
    local payload = {
        username = "TDS Farmer",
        avatar_url = "https://cdn-icons-png.flaticon.com/512/4708/4708820.png",
        embeds = {embed}
    }
    
    local jsonSuccess, jsonData = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    
    if not jsonSuccess then
        _E.printToConsole("JSON encoding failed: " .. tostring(jsonData), "error")
        return false
    end
    
    local decodeSuccess = pcall(function()
        return HttpService:JSONDecode(jsonData)
    end)
    
    if not decodeSuccess then
        _E.printToConsole("Invalid JSON generated", "error")
        return false
    end
    
    _E.printToConsole("Sending webhook...", "debug")
    
    local requestData = {
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = jsonData
    }
    
    local httpRequest = (syn and syn.request) or (http and http.request) or (http_request) or (fluxus and fluxus.request) or (request)
    
    if not httpRequest then
        _E.printToConsole("No HTTP request method available", "error")
        return false
    end
    
    local success, response = pcall(function()
        return httpRequest(requestData)
    end)
    
    if success then
        if response then
            _E.printToConsole("Response Code: " .. tostring(response.StatusCode), "debug")
            
            if response.StatusCode == 204 or response.StatusCode == 200 then
                _E.printToConsole("📨 Webhook sent successfully!", "success")
                return true
            else
                _E.printToConsole("Webhook failed with status " .. tostring(response.StatusCode), "error")
                return false
            end
        else
            _E.printToConsole("No response received", "error")
            return false
        end
    else
        _E.printToConsole("Failed to send webhook: " .. tostring(response), "error")
        return false
    end
end

function _E.sendGemsWebhook(currentGems, totalReceived)
    local webhook = getgenv().Webhook
    if webhook == "" or webhook == nil then
        _E.printToConsole("Webhook URL is empty", "error")
        return false
    end
    
    if not string.find(webhook, "https://discord.com/api/webhooks/") then
        _E.printToConsole("Invalid webhook URL format", "error")
        return false
    end
    
    local playerName = player.Name
    
    local runTimeSeconds = tick() - startTime
    local runHours = math.floor(runTimeSeconds / 3600)
    local runMinutes = math.floor((runTimeSeconds % 3600) / 60)
    local runSeconds = math.floor(runTimeSeconds % 60)
    local runTime = string.format("%02d:%02d:%02d", runHours, runMinutes, runSeconds)
    
    local embed = {
        title = "💰 money - TDS",
        color = 0x8B00FF,
        fields = {
            {
                name = "👤 Player:",
                value = "```" .. tostring(playerName) .. "```",
                inline = false
            },
            {
                name = "💰 Current coins:",
                value = "```" .. tostring(currentGems) .. "```",
                inline = true
            },
            {
                name = "⭐ Total Received:",
                value = "```" .. tostring(totalReceived) .. "```",
                inline = true
            },
            {
                name = "⏰ Local Time",
                value = "```" .. os.date("%H:%M:%S") .. "```",
                inline = true
            },
            {
                name = "🕐 Run Time",
                value = "```" .. tostring(runTime) .. "```",
                inline = true
            }
        },
        footer = {
            text = "TDS Farmer • " .. os.date("%d.%m.%Y")
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    
    local payload = {
        username = "TDS Farmer",
        avatar_url = "https://cdn-icons-png.flaticon.com/512/4708/4708820.png",
        embeds = {embed}
    }
    
    local jsonSuccess, jsonData = pcall(function()
        return HttpService:JSONEncode(payload)
    end)
    
    if not jsonSuccess then
        _E.printToConsole("JSON encoding failed: " .. tostring(jsonData), "error")
        return false
    end
    
    local decodeSuccess = pcall(function()
        return HttpService:JSONDecode(jsonData)
    end)
    
    if not decodeSuccess then
        _E.printToConsole("Invalid JSON generated", "error")
        return false
    end
    
    _E.printToConsole("Sending gems webhook...", "debug")
    
    local requestData = {
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = jsonData
    }
    
    local httpRequest = (syn and syn.request) or (http and http.request) or (http_request) or (fluxus and fluxus.request) or (request)
    
    if not httpRequest then
        _E.printToConsole("No HTTP request method available", "error")
        return false
    end
    
    local success, response = pcall(function()
        return httpRequest(requestData)
    end)
    
    if success then
        if response then
            _E.printToConsole("Response Code: " .. tostring(response.StatusCode), "debug")
            
            if response.StatusCode == 204 or response.StatusCode == 200 then
                _E.printToConsole("📨 Gems webhook sent successfully!", "success")
                return true
            else
                _E.printToConsole("Gems webhook failed with status " .. tostring(response.StatusCode), "error")
                return false
            end
        else
            _E.printToConsole("No response received", "error")
            return false
        end
    else
        _E.printToConsole("Failed to send gems webhook: " .. tostring(response), "error")
        return false
    end
end

function _E.testWebhook()
    local webhook = getgenv().Webhook
    if webhook == "" or webhook == nil then
        _E.printToConsole("Webhook URL is empty", "error")
        return false
    end
    
    testButton.Text = "..."
    testButton.BackgroundColor3 = Color3.fromRGB(100, 100, 60)
    
    local success, result = pcall(function()
        local runTimeSeconds = tick() - startTime
        local runHours = math.floor(runTimeSeconds / 3600)
        local runMinutes = math.floor((runTimeSeconds % 3600) / 60)
        local runSeconds = math.floor(runTimeSeconds % 60)
        local runTime = string.format("%02d:%02d:%02d", runHours, runMinutes, runSeconds)
        
        local data = {
            content = "Webhook Test - Console is working!",
            username = "Roblox Console",
            embeds = {{
                title = "Test Message",
                description = "This is a test message from Roblox Console",
                color = 65280,
                fields = {
                    {
                        name = "Status",
                        value = "✅ Working",
                        inline = true
                    },
                    {
                        name = "Time",
                        value = os.date("%H:%M:%S"),
                        inline = true
                    },
                    {
                        name = "Run Time",
                        value = runTime,
                        inline = true
                    },
                    {
                        name = "Game",
                        value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown",
                        inline = true
                    }
                },
                footer = {
                    text = "Test completed successfully"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }
        
        local jsonData = HttpService:JSONEncode(data)
        local request = (syn and syn.request) or (http_request) or request
        
        if request then
            local response = request({
                Url = webhook,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonData
            })
            return response
        else
            error("No HTTP request function available")
        end
    end)
    
    if success then
        testButton.Text = "OK"
        testButton.BackgroundColor3 = Color3.fromRGB(60, 150, 60)
        _E.printToConsole("Webhook test sent successfully!", "success")
        
        task.delay(2, function()
            if testButton then
                testButton.Text = "Test"
                testButton.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
            end
        end)
        
        return true
    else
        testButton.Text = "Fail"
        testButton.BackgroundColor3 = Color3.fromRGB(150, 60, 60)
        _E.printToConsole("Webhook test failed: " .. tostring(result), "error")
        
        task.delay(2, function()
            if testButton then
                testButton.Text = "Test"
                testButton.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
            end
        end)
        
        return false
    end
end

function _E.printToConsole(text, messageType)
    messageType = messageType or "info"
    
    RunService.Heartbeat:Wait()
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message_" .. _E.RS(8)
    messageLabel.Size = UDim2.new(1, -16, 0, 0)
    messageLabel.AutomaticSize = Enum.AutomaticSize.Y
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = "[" .. os.date("%H:%M:%S") .. "] " .. getMessageType(messageType) .. " " .. tostring(text)
    messageLabel.TextColor3 = getMessageColor(messageType)
    messageLabel.TextSize = 14
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.LayoutOrder = #outputFrame:GetChildren()
    messageLabel.Parent = outputFrame
    
    task.wait(0.05)
    outputFrame.CanvasPosition = Vector2.new(0, outputFrame.AbsoluteCanvasSize.Y)
end

function _E.clearConsole()
    for _, child in ipairs(outputFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    _E.printToConsole("Console cleared", "system")
end

saveButton.MouseButton1Click:Connect(function()
    getgenv().Webhook = webhookBox.Text
    _E.printToConsole("Webhook URL saved", "success")
end)

testButton.MouseButton1Click:Connect(function()
    _E.testWebhook()
end)

sendButton.MouseButton1Click:Connect(function()
    _E.sendGemsWebhook(getgenv().GemsT or 0, getgenv().RewarmA or 0)
end)

webhookBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        getgenv().Webhook = webhookBox.Text
        _E.printToConsole("Webhook URL updated", "success")
    end
end)

local dragging = false
local dragInput
local dragStart
local startPos

local resizing = false
local resizeInput
local resizeStart
local resizeStartSize

local function updateInput(input)
    if dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end

local function updateResize(input)
    if resizing then
        local delta = input.Position - resizeStart
        local newWidth = math.max(400, resizeStartSize.X.Offset + delta.X)
        local newHeight = math.max(300, resizeStartSize.Y.Offset + delta.Y)
        
        mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        resizeStart = input.Position
        resizeStartSize = mainFrame.Size
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

resizeHandle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        resizeInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateInput(input)
    elseif resizing and input == resizeInput then
        updateResize(input)
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    consoleGUI.Enabled = not consoleGUI.Enabled
end)

--[[closeButton.MouseButton1Click:Connect(function()
    consoleGUI:Destroy()
    _G.print = nil
    _G.clearConsole = nil
    _G.consoleToggle = nil
    _G.sendWebhook = nil
    _G.testWebhook = nil
    _G.sendGemsWebhook = nil
end)]]

clearButton.MouseButton1Click:Connect(function()
    _E.clearConsole()
end)

_G.print = _E.printToConsole
_G.clearConsole = _E.clearConsole
_G.sendWebhook = _E.sendWebhook
_G.testWebhook = _E.testWebhook
_G.sendGemsWebhook = _E.sendGemsWebhook
_G.consoleToggle = function()
    consoleGUI.Enabled = not consoleGUI.Enabled
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F8 then
        consoleGUI.Enabled = not consoleGUI.Enabled
    end
end)

local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
   
    if hours > 0 then
        return string.format("%d:%02d:%02d", hours, minutes, secs)
    elseif minutes > 0 then
        return string.format("%d:%02d", minutes, secs)
    else
        return string.format("%02d", secs)
    end
end

task.spawn(function()
    while consoleGUI.Parent do
        local elapsed = tick() - startTime
        runtimeLabel.Text = formatTime(elapsed)
        task.wait(1)
    end
end)

task.delay(1, function()
    _E.printToConsole("Console initialized successfully!", "success")
    _E.printToConsole("Press F8 to hide/show console", "system")
    if getgenv().Webhook ~= "" then
        _E.printToConsole("Webhook loaded: " .. getgenv().Webhook, "info")
    end
end)

if not consoleGUI.Parent then
    consoleGUI.Parent = CoreGui
end

return _E

local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local CoreGui = game:GetService("CoreGui");

local function protect_gui(gui)
    if syn and syn.protect_gui then
        syn.protect_gui(gui);
    end;
    gui.Parent = CoreGui;
end;

local function RandomString(len)
    local s = "";
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for i = 1, len or 12 do
        local r = math.random(1, #chars);
        s = s .. chars:sub(r, r);
    end;
    return s;
end;

local SpaceHubGUI = Instance.new("ScreenGui");
SpaceHubGUI.Name = RandomString(10);
SpaceHubGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
protect_gui(SpaceHubGUI);

local MainContainer = Instance.new("Frame");
local UICorner = Instance.new("UICorner");
local Header = Instance.new("Frame");
local HeaderCorner = Instance.new("UICorner");
local Title = Instance.new("TextLabel");
local CloseButton = Instance.new("TextButton");
local CloseCorner = Instance.new("UICorner");
local ContentFrame = Instance.new("Frame");
local ButtonContainer = Instance.new("Frame");
local AutoMoneyButton = Instance.new("TextButton");
local AutoMoneyCorner = Instance.new("UICorner");
local AutoGemsButton = Instance.new("TextButton");
local AutoGemsCorner = Instance.new("UICorner");
local MacroButton = Instance.new("TextButton");
local MacroCorner = Instance.new("UICorner");
local Footer = Instance.new("Frame");
local DiscordLabel = Instance.new("TextLabel");
local Divider = Instance.new("Frame");

MainContainer.Name = RandomString(8);
MainContainer.Parent = SpaceHubGUI;
MainContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
MainContainer.BorderSizePixel = 0;
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0);
MainContainer.Size = UDim2.new(0, 280, 0, 190);
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5);
MainContainer.ClipsDescendants = true;

UICorner.Parent = MainContainer;
UICorner.CornerRadius = UDim.new(0, 10);

Header.Name = RandomString(6);
Header.Parent = MainContainer;
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
Header.BorderSizePixel = 0;
Header.Size = UDim2.new(1, 0, 0, 40);

HeaderCorner.Parent = Header;
HeaderCorner.CornerRadius = UDim.new(0, 10);

Title.Name = RandomString(6);
Title.Parent = Header;
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
Title.BackgroundTransparency = 1;
Title.Position = UDim2.new(0, 15, 0, 0);
Title.Size = UDim2.new(0, 200, 1, 0);
Title.Font = Enum.Font.GothamBold;
Title.Text = "SPACE HUB - TDS";
Title.TextColor3 = Color3.fromRGB(240, 240, 240);
Title.TextSize = 16;
Title.TextXAlignment = Enum.TextXAlignment.Left;

CloseButton.Name = RandomString(6);
CloseButton.Parent = Header;
CloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
CloseButton.BorderSizePixel = 0;
CloseButton.Position = UDim2.new(1, -35, 0, 8);
CloseButton.Size = UDim2.new(0, 24, 0, 24);
CloseButton.Font = Enum.Font.GothamBold;
CloseButton.Text = "×";
CloseButton.TextColor3 = Color3.fromRGB(220, 220, 220);
CloseButton.TextSize = 18;

CloseCorner.Parent = CloseButton;
CloseCorner.CornerRadius = UDim.new(1, 0);

ContentFrame.Name = RandomString(8);
ContentFrame.Parent = MainContainer;
ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
ContentFrame.BackgroundTransparency = 1;
ContentFrame.Position = UDim2.new(0, 0, 0, 40);
ContentFrame.Size = UDim2.new(1, 0, 1, -40);

ButtonContainer.Name = RandomString(8);
ButtonContainer.Parent = ContentFrame;
ButtonContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
ButtonContainer.BackgroundTransparency = 1;
ButtonContainer.Position = UDim2.new(0, 15, 0, 20);
ButtonContainer.Size = UDim2.new(1, -30, 0, 110);

AutoMoneyButton.Name = RandomString(6);
AutoMoneyButton.Parent = ButtonContainer;
AutoMoneyButton.BackgroundColor3 = Color3.fromRGB(40, 150, 70);
AutoMoneyButton.BorderSizePixel = 0;
AutoMoneyButton.Position = UDim2.new(0, 0, 0, -15);
AutoMoneyButton.Size = UDim2.new(1, 0, 0, 32);
AutoMoneyButton.Font = Enum.Font.GothamSemibold;
AutoMoneyButton.Text = "Auto Money";
AutoMoneyButton.TextColor3 = Color3.fromRGB(250, 250, 250);
AutoMoneyButton.TextSize = 14;
AutoMoneyButton.TextWrapped = true;

AutoMoneyCorner.Parent = AutoMoneyButton;
AutoMoneyCorner.CornerRadius = UDim.new(0, 7);

AutoGemsButton.Name = RandomString(6);
AutoGemsButton.Parent = ButtonContainer;
AutoGemsButton.BackgroundColor3 = Color3.fromRGB(180, 70, 140);
AutoGemsButton.BorderSizePixel = 0;
AutoGemsButton.Position = UDim2.new(0, 0, 0, 23);
AutoGemsButton.Size = UDim2.new(1, 0, 0, 32);
AutoGemsButton.Font = Enum.Font.GothamSemibold;
AutoGemsButton.Text = "Auto Gems";
AutoGemsButton.TextColor3 = Color3.fromRGB(250, 250, 250);
AutoGemsButton.TextSize = 14;
AutoGemsButton.TextWrapped = true;

AutoGemsCorner.Parent = AutoGemsButton;
AutoGemsCorner.CornerRadius = UDim.new(0, 7);

MacroButton.Name = RandomString(6);
MacroButton.Parent = ButtonContainer;
MacroButton.BackgroundColor3 = Color3.fromRGB(70, 120, 180);
MacroButton.BorderSizePixel = 0;
MacroButton.Position = UDim2.new(0, 0, 0, 61);
MacroButton.Size = UDim2.new(1, 0, 0, 32);
MacroButton.Font = Enum.Font.GothamSemibold;
MacroButton.Text = "Macro Recorder";
MacroButton.TextColor3 = Color3.fromRGB(250, 250, 250);
MacroButton.TextSize = 14;
MacroButton.TextWrapped = true;

MacroCorner.Parent = MacroButton;
MacroCorner.CornerRadius = UDim.new(0, 7);

Footer.Name = RandomString(6);
Footer.Parent = ContentFrame;
Footer.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
Footer.BackgroundTransparency = 1;
Footer.Position = UDim2.new(0, 0, 1, -35);
Footer.Size = UDim2.new(1, 0, 0, 35);

Divider.Name = RandomString(6);
Divider.Parent = Footer;
Divider.BackgroundColor3 = Color3.fromRGB(55, 55, 55);
Divider.BorderSizePixel = 0;
Divider.Position = UDim2.new(0, 0, 0, 0);
Divider.Size = UDim2.new(1, 0, 0, 1);

DiscordLabel.Name = RandomString(8);
DiscordLabel.Parent = Footer;
DiscordLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
DiscordLabel.BackgroundTransparency = 1;
DiscordLabel.Position = UDim2.new(0, 10, 0, 8);
DiscordLabel.Size = UDim2.new(1, -20, 1, -16);
DiscordLabel.Font = Enum.Font.Gotham;
DiscordLabel.Text = "Guide/Buy Premium: dsc.gg/spacerb";
DiscordLabel.TextColor3 = Color3.fromRGB(160, 160, 160);
DiscordLabel.TextSize = 13;
DiscordLabel.TextXAlignment = Enum.TextXAlignment.Center;

local function createButtonEffect(button)
    local originalR, originalG, originalB = button.BackgroundColor3.R * 255, button.BackgroundColor3.G * 255, button.BackgroundColor3.B * 255;
    
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(
                math.min(originalR + 25, 255),
                math.min(originalG + 25, 255),
                math.min(originalB + 25, 255)
            )
        });
        tween:Play();
    end);
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(originalR, originalG, originalB)
        });
        tween:Play();
    end);
    
    button.MouseButton1Down:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(
                math.max(originalR - 30, 0),
                math.max(originalG - 30, 0),
                math.max(originalB - 30, 0)
            )
        });
        tween:Play();
    end);
    
    button.MouseButton1Up:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.fromRGB(
                math.min(originalR + 15, 255),
                math.min(originalG + 15, 255),
                math.min(originalB + 15, 255)
            )
        });
        tween:Play();
    end);
end;

createButtonEffect(AutoMoneyButton);
createButtonEffect(AutoGemsButton);
createButtonEffect(MacroButton);
createButtonEffect(CloseButton);

local function destroyGUI()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local tween = TweenService:Create(MainContainer, tweenInfo, {
        Position = UDim2.new(0.5, 0, 1.5, 0),
        BackgroundTransparency = 1
    });
    tween:Play();
    tween.Completed:Connect(function()
        SpaceHubGUI:Destroy();
    end);
end;

AutoMoneyButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/AutoMoney.lua"))();
    destroyGUI();
end);

AutoGemsButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/AutoGems.lua"))();
    destroyGUI();
end);

MacroButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/Recorder.lua"))();
    destroyGUI();
end);

CloseButton.MouseButton1Click:Connect(function()
    destroyGUI();
end);

local dragging = false;
local dragInput, dragStart, startPos;

local function update(input)
    local delta = input.Position - dragStart;
    MainContainer.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    );
end;

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true;
        dragStart = input.Position;
        startPos = MainContainer.Position;
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false;
            end;
        end);
    end;
end);

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input;
    end;
end);

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input);
    end;
end);

MainContainer.Position = UDim2.new(0.5, 0, 0.3, 0);
MainContainer.BackgroundTransparency = 1;

local entranceTween = TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundTransparency = 0
});
entranceTween:Play();

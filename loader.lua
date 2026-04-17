repeat task.wait(0.1) until game:IsLoaded();
print("[Space Hub]: Premium Script Loading...")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if TDS then
    getgenv().GameName = "TDS";
end
if beta then
    getgenv().BetaTest = true;
end
if game then
    getgenv().GameName = game;
end
if not script_key then
    LocalPlayer:Kick("Use | script_key=\"\"")
    warn("[Space Hub]: Not script_key in loader")
    return;
end;

getgenv().Key = script_key;
loadstring(game:HttpGet("https://f.space-hub.cc/Premium/Loader.lua"))()

repeat task.wait(0.1) until game:IsLoaded()
print("[Space Hub]: Premium Script Loading...")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if TDS then
    getgenv().GameName = "TDS"
end

if beta then
    getgenv().BetaTest = true
end

local providedKey = tostring(script_key or "")
if providedKey:gsub("%s+", "") == "" then
    LocalPlayer:Kick('Use script_key="<your_key>"')
    warn("[Space Hub]: script_key was not provided")
    return
end

getgenv().Key = providedKey
_G.Key = providedKey
loadstring(game:HttpGet("https://f.space-hub.cc/Premium.lua"))()

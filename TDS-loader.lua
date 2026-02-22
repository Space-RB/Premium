--[[
Game - 5591597781
Lobby - 3260590327
]]

if not game:IsLoaded() then game.Loaded:Wait() end
local lp = game:GetService("Players").LocalPlayer
local e = pcall(getexecutorname) and getexecutorname() or (identifyexecutor and identifyexecutor()) or "Unknown"
if e:match("Solara") or e:match("Xeno") or e:match("JJSploit x Xeno") or e:match("Zeno") or e:match("Luna") then
    lp:Kick("Executor not supported") while true do print("Unsupported") end
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/Utility/UI.lua"))();

--[[if getgenv().BetaTest == true then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/Utility/UI.lua"))();
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/Utility/OldSelectorUI.lua"))();
end]]

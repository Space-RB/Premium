--[[
Game - 5591597781
Lobby - 3260590327
]]

if getgenv().BetaTest == true then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/Utility/UI.lua"))();
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Space-RB/Premium/refs/heads/main/Scripts/TDS/Utility/OldSelectorUI.lua"))();
end

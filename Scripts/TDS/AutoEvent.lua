local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local plr = Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local root = chr:WaitForChild("HumanoidRootPart")
local start = root.Position
local active = false

local function findAndCollect()
    if active then return end
    
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("MeshPart") and v.Name=="SnowCharm" and (v.Position-root.Position).Magnitude<40 then
            active = true
            TweenService:Create(root,TweenInfo.new(0.3),{Position=v.Position}):Play()
            task.wait(0.3)
            v:Destroy()
            task.wait(0.2)
            active = false
            findAndCollect()
            return
        end
    end
end

while true do
    findAndCollect()
    task.wait()
end

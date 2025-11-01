-- Original Player ESP written by sly.sheen1337
-- Modded by fijidacherry for Murd and Sheriff detect lawl

print("thanks for using this script <3")
--yes you can skid this its nothing special

local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local camera = workspace.CurrentCamera

local boxes = {}
local lastupdate = 0

local function worldtoscreen(pos)
    return WorldToScreen(pos)
end

local function getbbox(char)
    local min_x, min_y = math.huge, math.huge
    local max_x, max_y = -math.huge, -math.huge
    local found = false
    
    for _, part in pairs(char:GetChildren()) do
        if part.ClassName:lower():find("part") then
            local pos = part.Position
            local sz = part.Size / 2
            
            for _, offset in pairs({Vector3.new(-sz.X, -sz.Y, -sz.Z), Vector3.new(sz.X, sz.Y, sz.Z)}) do
                local screen, vis = worldtoscreen(pos + offset)
                if vis then
                    found = true
                    min_x = math.min(min_x, screen.x)
                    min_y = math.min(min_y, screen.y)
                    max_x = math.max(max_x, screen.x)
                    max_y = math.max(max_y, screen.y)
                end
            end
        end
    end
    
    return found, min_x, min_y, max_x - min_x, max_y - min_y
end

local function Murderer(player)
    if player and player.Character then

        local backpack = player:FindFirstChildOfClass("Backpack")
        if backpack then
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") and item.Name:lower():find("knife") then
                    return true
                end
            end
        end
        for _, item in ipairs(player.Character:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find("knife") then
                return true
            end
        end
    end
    return false
end

local function Sheriff(player)
    if player and player.Character then

        local backpack = player:FindFirstChildOfClass("Backpack")
        if backpack then
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") and item.Name:lower():find("gun") then
                    return true
                end
            end
        end
        for _, item in ipairs(player.Character:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find("gun") then
                return true
            end
        end
    end
    return false
end

local function add_esp(plr)
    local box = {
        outline1 = Drawing.new("Square"),
        outline2 = Drawing.new("Square"),
        main = Drawing.new("Square"),
        name = Drawing.new("Text")
    }
    
    box.outline1.Thickness = 1
    box.outline1.Filled = false
    box.outline1.Color = Color3.fromRGB(0, 0, 0)
    
    box.outline2.Thickness = 1
    box.outline2.Filled = false
    box.outline2.Color = Color3.fromRGB(0, 0, 0)
    
    box.main.Thickness = 1
    box.main.Filled = false
    box.main.Color = Color3.fromRGB(255, 255, 255)
    
    box.name.Text = plr.Name
    box.name.Color = Color3.fromRGB(255, 255, 255)
    box.name.Center = true
    box.name.Outline = true
    
    boxes[plr] = box
end

local function remove_esp(plr)
    if boxes[plr] then
        boxes[plr].outline1:Remove()
        boxes[plr].outline2:Remove()
        boxes[plr].main:Remove()
        boxes[plr].name:Remove()
        boxes[plr] = nil
    end
end

while true do
    local time = os.clock()
    
    if time - lastupdate > 1 then
        local playerlist = players:GetChildren()
        
        if boxes[localplayer] then
            remove_esp(localplayer)
        end
        
        for plr, _ in pairs(boxes) do
            remove_esp(plr)
        end
        
        for _, plr in pairs(playerlist) do
            if plr.ClassName == "Player" and plr ~= localplayer and plr.Name ~= localplayer.Name then
                add_esp(plr)
            end
        end
        
        lastupdate = time
    end
    
    for plr, box in pairs(boxes) do
        box.outline1.Visible = false
        box.outline2.Visible = false
        box.main.Visible = false
        box.name.Visible = false
        
        if plr and plr ~= localplayer and plr.Name ~= localplayer.Name and plr.Character then
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local ok, x, y, w, h = getbbox(plr.Character)
                if ok then
                    if Murderer(plr) then
                        box.main.Color = Color3.fromRGB(255, 0, 0)
                        box.name.Color = Color3.fromRGB(255, 0, 0)
                    elseif Sheriff(plr) then 
                        box.main.Color = Color3.fromRGB(0, 0, 255)
                        box.name.Color = Color3.fromRGB(0, 0, 255)

                    else
                        box.main.Color = Color3.fromRGB(255, 255, 255)
                        box.name.Color = Color3.fromRGB(255, 255, 255)
                    end
                    
                    box.outline1.Position = Vector2.new(x + 1, y + 1)
                    box.outline1.Size = Vector2.new(w - 2, h - 2)
                    box.outline1.Visible = true
                    
                    box.outline2.Position = Vector2.new(x - 1, y - 1)
                    box.outline2.Size = Vector2.new(w + 2, h + 2)
                    box.outline2.Visible = true
                    
                    box.main.Position = Vector2.new(x, y)
                    box.main.Size = Vector2.new(w, h)
                    box.main.Visible = true
                    
                    box.name.Position = Vector2.new(x + w / 2, y - 16)
                    box.name.Visible = true
                end
            end
        end
    end
    
    wait(0.007) -- 60 fps / 0.007 - 144fps / 0.004 - 240fps
end

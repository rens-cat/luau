-- some games dont work idk why should work usually
-- enjoy ur stupid obby script
print("fiji made this guys FAHHH")

local player = game.Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")


local path = PathToCheckpoints

if not path then
    local possibleFolderNames = {
        "Stages", "Checkpoints", "Checkpoint", "Levels", "Level", "Stage", "StageFolder", "CheckpointFolder", "CheckpointsFolder", "LevelsFolder", "LevelFolder"
    }
    
    for _, folderName in pairs(possibleFolderNames) do
        local testFolder = workspace:FindFirstChild(folderName)
        if testFolder then
            path = testFolder
            break
        end
    end
end

if not path then
    print("the script cannot find the folder")
    return
end

print("found the folder starting tping in 3 seconds")
wait(3)

for i = 1, 1000 do
    local checkpoint = path:FindFirstChild(tostring(i))
    if checkpoint then
        rootPart.Position = checkpoint.Position + Vector3.new(0, 3, 0)
        wait(0.32)
    else
        break
    end
end

print("script completed")

-- fijidacherry on discord made this script for your entertainment! <3
-- dont try to execute this on anything that isnt matcha lol idk if itll work
-- k thx bye

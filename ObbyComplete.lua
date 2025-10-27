-- some games dont work idk why should work usually
-- enjoy ur stupid obby script
print("fiji made this guys FAHHH")
------------------------------- Dont touch beyond here.

local player = game.Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local path = PathToCheckpoints
if not path then
    print("you dont have the correct folder where the checkpoints are stored inside of the game. look thru the explorer.")
    return
end

print("found the folder starting tping in 3 seconds")
wait(3)

for i = 1, 1000 do
    local checkpoint = path:FindFirstChild(tostring(i))
    if checkpoint then
        rootPart.Position = checkpoint.Position + Vector3.new(0, 3, 0)
        wait(TimeTillTp)
    else
        break
    end
end

print("script completed")

-- fijidacherry on discord made this script for your entertainment! <3
-- dont try to execute this on anything that isnt matcha lol idk if itll work
-- k thx bye

--[[
	This module is used to insert your game. Feel free to edit it below to fit your needs.
	
	To use Game Module Maker:
		This module should always be named "GameModule". This allows your game can be loaded and ran via InsertService.
		
		In all places that will receive this game's code, make a single script in ServerScriptService with the source:
			require(game:GetService("InsertService"):LoadAsset(12345).GameModule) -- Where 12345 is your model's asset ID
			
	
	The commented blocks below are optional security measures if you are paranoid about access issues within your group.
]]

local Children = script:GetChildren()

-- Prevent children from being accessed if reference to script is acquired
--[[
	script = Instance.new("ModuleScript")
	for _, Child in pairs(Children) do
		Child.Parent = script
	end
--]]

-- Prevent module from being run in unauthorized games:
--[[
if game.CreatorType ~= Enum.CreatorType.Group or game.CreatorId ~= 7568236 then
	return nil
end
--]]

-- Attempt to block SavePlace calls so that server code is not leaked:
--[[
do
	local saveSuccessful = pcall(function()
		game:GetService("AssetService"):SavePlaceAsync()
	end)
	
	if saveSuccessful then
		return nil
	end
end
]]

-- Insert the game into this place
pcall(function()
	for _, child in pairs(Children) do
		local service
		if game:GetService(child.Name) then
			service = game:GetService(child.Name)
		elseif game:GetService("StarterPlayer"):FindFirstChild(child.Name) then
			service = game:GetService("StarterPlayer")[child.Name]
		end

		if service then
			for _, child in pairs(child:GetChildren()) do
				child.Parent = service
			end
		end
	end
end)


return nil

local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local Player = Players.LocalPlayer

local AutoBuyEnabled = false
local GodModeEnabled = false
local ESPLaunched = false
local IYLaunched = false

wait(3)

local UIClone1 = Player.PlayerGui.MenuButtons:Clone()
Player.PlayerGui.MenuButtons:Destroy()
UIClone1.ResetOnSpawn = false
UIClone1.Parent = Player.PlayerGui

local UIClone2 = Player.PlayerGui.MenuGui:Clone()
Player.PlayerGui.MenuGui:Destroy()
UIClone2.ResetOnSpawn = false
UIClone2.Parent = Player.PlayerGui

local MenuButton = Player.PlayerGui.MenuButtons.Buttons.CallHorse:Clone()
MenuButton.Name = 'ModMenu'
MenuButton.ImageColor3 = Color3.fromRGB(117, 117, 117)
MenuButton.Title.Text = 'Mod Menu'
MenuButton.Parent = Player.PlayerGui.MenuButtons.Buttons

local MenuFrame = Player.PlayerGui.MenuGui.Menu:Clone()
MenuFrame.Name = 'ModMenu'
MenuFrame.MenuTip:Destroy()
MenuFrame.Title.TextLabel.Text = 'Mod Menu'
MenuFrame.ScrollingFrame.Settings:Destroy()
MenuFrame.ScrollingFrame.Map:Destroy()
MenuFrame.ScrollingFrame.BecomeOutlaw:Destroy()
MenuFrame.ScrollingFrame.Tutorial.Parent = script
script.Tutorial.Name = 'Button'
MenuFrame.Parent = Player.PlayerGui.MenuGui

local GodModeDisplay = Player.PlayerGui.InfoGui.Team:Clone()
GodModeDisplay.Name = 'GodMode'
GodModeDisplay.Position = UDim2.fromScale(0.942, 0.88)
GodModeDisplay.Parent = Player.PlayerGui.MenuGui
GodModeDisplay.State.Text = 'Not Godded'
GodModeDisplay.State.Size = UDim2.fromScale(0.847, 1)
GodModeDisplay.State.Position = UDim2.fromScale(0.074, 0)

print(GodModeDisplay.Parent.Name)

local function SetMods(Mods)
	for _, Gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
		for Prop, Value in pairs(Mods) do
			if Gun[Prop] then
				Gun[Prop] = Value
			end
		end
	end
end

local function CreateButton(ButtonName, FunctionCall)
	local ButtonClone = script.Button:Clone()
	ButtonClone.Parent = MenuFrame.ScrollingFrame
	ButtonClone.Name = ButtonName
	ButtonClone.Title.Text = ButtonName
	
	
	if ButtonName == '[Z] God Mode: Disabled' then
		UserInputService.InputBegan:Connect(function(Input, GameProcessed)
			if not GameProcessed then
				if Input.KeyCode == Enum.KeyCode.Z then
					if GodModeEnabled then
						GodModeEnabled = false
						Player.PlayerGui.MenuGui.ModMenu.ScrollingFrame:FindFirstChild('[Z] God Mode: Disabled').Title.Text = '[Z] God Mode: Disabled'
						GodModeDisplay.State.Text = 'Not Godded'
						game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", false)
					else
						GodModeEnabled = true
						Player.PlayerGui.MenuGui.ModMenu.ScrollingFrame:FindFirstChild('[Z] God Mode: Disabled').Title.Text = '[Z] God Mode: Enabled'
						GodModeDisplay.State.Text = 'Godded'
						game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", true)
						game.Players.LocalPlayer.Character.ForceField.Visible = false
					end
				end
			end
		end)
	else
		ButtonClone.MouseButton1Click:Connect(FunctionCall)
	end
end

MenuButton.MouseButton1Click:Connect(function()
	if MenuFrame.Visible then
		MenuFrame.Visible = false
	else
		MenuFrame.Visible = true
	end
end)

MenuFrame.Close.MouseButton1Click:Connect(function()
	MenuFrame.Visible = false
end)

CreateButton('Gun Mods: Disabled', function()
	local Mods = {
		FanFire = true, 
		camShakeResist = 0, 
		Spread = 0, 
		prepTime = 0, 
		equipTime = 0, 
		ReloadAnimationSpeed = 0,
		ReloadSpeed = 0, 
		HipFireAccuracy = 0, 
		ZoomAccuracy = 0, 
		InstantFireAnimation = true
	}
	SetMods(Mods)
	
	Player.PlayerGui.MenuGui.ModMenu.ScrollingFrame:FindFirstChild('Gun Mods: Disabled').Title.Text = 'Gun Mods: Enabled'
end)

CreateButton('[Z] God Mode: Disabled', function()
	
end)

CreateButton('Auto Buy: Disabled', function()
	if AutoBuyEnabled then
		AutoBuyEnabled = false
		Player.PlayerGui.MenuGui.ModMenu.ScrollingFrame:FindFirstChild('Auto Buy: Disabled').Title.Text = 'Auto Buy: Disabled'
	else
		AutoBuyEnabled = true
		Player.PlayerGui.MenuGui.ModMenu.ScrollingFrame:FindFirstChild('Auto Buy: Disabled').Title.Text = 'Auto Buy: Enabled'
	end
end)

CreateButton('Launch ESP', function()
	if not ESPLaunched then
		ESPLaunched = true
		loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()
	end
end)

CreateButton('Launch IY', function()
	if not IYLaunched then
		IYLaunched = true
		loadstring(game:HttpGet('http://impulse-hub.xyz/ImpulseIY',true))()
	end
end)

while wait(0.1) do
	if AutoBuyEnabled then
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("PistolAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("RifleAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("ShotgunAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("Dynamite",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("SniperAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("BIG Dynamite",true)
	end
end

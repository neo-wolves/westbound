local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local AutoBuyEnabled = false
local GodModeEnabled = false
local ESPLaunched = false
local IYLaunched = false

wait(1)

Player.PlayerGui.MenuButtons.ResetOnSpawn = false
Player.PlayerGui.MenuGui.ResetOnSpawn = false

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
	
	ButtonClone.MouseButton1Click:Connect(FunctionCall)
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

CreateButton('God Mode: Disabled', function()
	if GodModeEnabled then
		GodModeEnabled = false
		Player.PlayerGui.MenuGui.ModMenu.ScrollingFrame:FindFirstChild('God Mode: Disabled').Title.Text = 'God Mode: Disabled'
		game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", false)
	else
		GodModeEnabled = true
		Player.PlayerGui.MenuGui.ModMenu.ScrollingFrame:FindFirstChild('God Mode: Disabled').Title.Text = 'God Mode: Enabled'
		game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", true)
		game.Players.LocalPlayer.Character.ForceField.Visible = false
	end
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
		loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()
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

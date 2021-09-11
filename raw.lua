-- Variables
local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local Player = Players.LocalPlayer

local AutoBuyEnabled = false
local GodModeEnabled = false
local AutoHealEnabled = false
local AddonsLaunched = false
local CurrentShop = ''

-- Create UI Elements
local UILibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/neo-wolves/westbound/main/library.lua',true))()
local Menu = UILibrary.AddMenu()
UILibrary.AddButton(Menu[1], 'Gun Mods', 'Disabled')
UILibrary.AddButton(Menu[1], 'Auto Buy/ Sell', 'Disabled')
UILibrary.AddButton(Menu[1], 'Auto Heal', 'Disabled')
UILibrary.AddButton(Menu[1], 'Launch ESP/ Admin', 'Launch')
local Buttons = {}

for _,Frame in pairs(Menu[1]:GetChildren()) do
	print(Frame)
	if Frame:IsA('Frame') then
		Buttons[Frame.TextLabel.Text] = Frame.ImageButton
	end
end

-- Global Functions
local function StartLoop()
	while wait(0.15) do
		if AutoBuyEnabled then

			for _,Shop in pairs(workspace.Shops:GetChildren()) do
				local Magnitude = (Shop.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude

				if CurrentShop ~= Shop.Name and Magnitude <= 15 then
					CurrentShop = Shop.Name

					game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("PistolAmmo",true)
					game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("RifleAmmo",true)
					game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("ShotgunAmmo",true)
					game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("Dynamite",true)
					game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("SniperAmmo",true)
					game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("BIG Dynamite",true)
					game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("Health Potion",true)
					game:GetService("ReplicatedStorage").GeneralEvents.Inventory:InvokeServer("Sell")
				elseif CurrentShop == Shop.Name and Magnitude > 15 then
					CurrentShop = ''
				end
			end
		end

		if AutoHealEnabled then
			local Character = workspace:FindFirstChild(Player.Name)

			if Character then
				if Character.Humanoid.Health <= 35 and Character.Humanoid.Health > 0 then
					game:GetService("Players").LocalPlayer.Backpack["Health Potion"].DrinkPotion:InvokeServer()
				end
			end
		end
	end
end

local function SetMods(Mods)
	for _, Gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
		for Prop, Value in pairs(Mods) do
			if Gun[Prop] then
				Gun[Prop] = Value
			end
		end
	end
end

Player.CharacterAdded:Connect(function()
	wait(0.5)

	game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", false)
	StartLoop()

	GodModeEnabled = false
	Menu[2].Text = 'Ungodded'

	for _,Tool in pairs(Player.Backpack:GetChildren()) do
		if Tool:IsA('Tool') then
			Tool.Equipped:Connect(function()
				GodModeEnabled = false
				Menu[2].Text = 'Ungodded'
			end)
		end
	end

	game.Players.LocalPlayer.Character.Head.NameTag:Destroy()
end)

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
	if not GameProcessed then
		if Input.KeyCode == Enum.KeyCode.Z then
			if GodModeEnabled then
				GodModeEnabled = false
				Menu[2].Text = 'Ungodded'
				game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", false)
			else
				game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", true)

				if game.Players.LocalPlayer.Character:FindFirstChild('ForceField') then
					GodModeEnabled = true
					Menu[2].Text = 'Godded'

					game.Players.LocalPlayer.Character.ForceField.Visible = false
				else
					Menu[2].Text = 'No Shop Nearby'

					wait(1.5)

					Menu[2].Text = 'Ungodded'
				end
			end
		end
	end
end)

-- Element Functions
Buttons['Gun Mods'].MouseButton1Click:Connect(function()
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
    
    	Buttons['Gun Mods'].TextLabel.Text = 'Enabled'
end)

Buttons['Auto Buy/ Sell'].MouseButton1Click:Connect(function()
	if AutoBuyEnabled then
		AutoBuyEnabled = false
		Buttons['Auto Buy/ Sell'].TextLabel.Text = 'Disabled'
    	else
		AutoBuyEnabled = true
		Buttons['Auto Buy/ Sell'].TextLabel.Text = 'Enabled'
    	end	
end)
		
Buttons['Auto Heal'].MouseButton1Click:Connect(function()
	if AutoHealEnabled then
		AutoHealEnabled = false
		Buttons['Auto Heal'].TextLabel.Text = 'Disabled'
    	else
		AutoHealEnabled = true
		Buttons['Auto Heal'].TextLabel.Text = 'Enabled'
    	end			
end)

Buttons['Launch ESP/ Admin'].MouseButton1Click:Connect(function()
	if not AddonsLaunched then
		AddonsLaunched = true
		loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()
		loadstring(game:HttpGet('http://impulse-hub.xyz/ImpulseIY',true))()

		Buttons['Launch ESP/ Admin'].TextLabel.Text = 'Launched'
    	end
end)

StartLoop()

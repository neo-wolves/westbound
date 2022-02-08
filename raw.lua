-- Variables
local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Player = Players.LocalPlayer

local AutoBuyEnabled = false
local GodModeEnabled = false
local AutoHealEnabled = false
local AddonsLaunched = false
local BoxesEnabled = false
local CurrentShop = ''

-- Create UI Elements
local UILibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/neo-wolves/westbound/main/library.lua',true))()
local Menu = UILibrary.AddMenu()
UILibrary.AddButton(Menu[1], 'Gun Mods', 'Disabled')
UILibrary.AddButton(Menu[1], 'Auto Buy/ Sell', 'Disabled')
UILibrary.AddButton(Menu[1], 'Auto Heal', 'Disabled')
UILibrary.AddButton(Menu[1], 'Launch ESP/ Admin', 'Launch')
UILibrary.AddButton(Menu[1], 'Break Window', 'Break')
UILibrary.AddButton(Menu[1], 'Shop Boxes', 'Disabled')
local Buttons = {}
local ShopBoxes = {}

print('Line 26')

for _,Frame in pairs(Menu[1]:GetChildren()) do
	print(Frame)
	if Frame:IsA('Frame') then
		Buttons[Frame.TextLabel.Text] = Frame.ImageButton
	end
end

-- Global Functions
local function BreakWindow()
	for _,Window in pairs(game.ReplicatedStorage.ContextStreaming:GetChildren()) do
		if Window.Name == 'Window' and game.Players.LocalPlayer.TeamColor ~= BrickColor.New('Bright red') then
			if Window.Part.Transparency == 0.5 then
				game:GetService("ReplicatedStorage").GeneralEvents.WindowBreak:FireServer(Window)
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

Buttons['Break Window'].MouseButton1Click:Connect(function()
	spawn(function()
		BreakWindow()
		wait(0.1)
		BreakWindow()
		wait(0.1)
		BreakWindow()
		wait(0.1)
		BreakWindow()
		wait(0.1)
	end)
end)

Buttons['Shop Boxes'].MouseButton1Click:Connect(function()
	if BoxesEnabled then
		BoxesEnabled = false
		Buttons['Shop Boxes'].TextLabel.Text = 'Disabled'
		for _,Box in pairs(ShopBoxes) do
			Box.Transparency = 1
		end
	else
		BoxesEnabled = true
		Buttons['Shop Boxes'].TextLabel.Text = 'Enabled'
		if not ShopBoxes[1] then
			for _,Shop in pairs(workspace.Shops:GetChildren()) do
				print(Shop)
				local Part = Instance.new('Part')
				Part.Anchored = true
				Part.Color = Color3.fromRGB(255, 0, 0)
				Part.CanCollide = false
				Part.Transparency = 0.9
				Part.Size = Vector3.new(15, 15, 15)
				Part.Position = Shop.Head.ShopPart.Position
				Part.Rotation = Shop.Head.ShopPart.Rotation
				table.insert(ShopBoxes, Part)
				Part.Parent = Shop.Head.ShopPart
			end
		end
		for _,Box in pairs(ShopBoxes) do
			Box.Transparency = 0.9
		end
	end
end)

-- Character Check
Player.CharacterAdded:Connect(function()
	wait(0.5)

	game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", false)

	GodModeEnabled = false
	Menu[2].Text = 'Ungodded'

	game.Players.LocalPlayer.Character.Head.NameTag:Destroy()
	
	Player.Character.Humanoid.Died:Connect(function()
		Menu[2].Text = 'Ungodded'
		GodModeEnabled = false
	end)
end)

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
	if not GameProcessed then
		if Input.KeyCode == Enum.KeyCode.Z then
			print('Z')
			if GodModeEnabled then
				print('Ungodded')
				GodModeEnabled = false
				Menu[2].Text = 'Ungodded'
				game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", false)
			else
				game:GetService("ReplicatedStorage").GeneralEvents.CustomizeCharacter:InvokeServer("Shopping", true)

				if game.Players.LocalPlayer.Character:FindFirstChild('ForceField') then
					print('Godded')
					GodModeEnabled = true
					Menu[2].Text = 'Godded'

					game.Players.LocalPlayer.Character.ForceField.Visible = false
					Player.StateConfig:WaitForChild('CharacterDisabled').Value = false

					Menu[2].Text = 'Ungodded'
				else
					Menu[2].Text = 'No Shop Nearby'

					wait(1.5)

					Menu[2].Text = 'Ungodded'
				end
			end
		end
	end
end)

-- Loop

print('Line 198')

RunService.RenderStepped:Connect(function()
	local Humanoid = Player.Character:FindFirstChild('Humanoid')
	if Humanoid then
		local X, Z = 0, 0

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			Z = -1
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			X = -1
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			Z = 1
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			X = 1
		end

		Humanoid:Move(Vector3.new(X, 0, Z), true)
	end

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

	if GodModeEnabled then
		if not game.Players.LocalPlayer.Character:FindFirstChild('ForceField') then
			GodModeEnabled = false
			Menu[2].Text = 'Ungodded'
		end
	end
end)

print('Line 261')

UserInputService.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.Space then
		local Humanoid = Player.Character:FindFirstChild('Humanoid')
		if Humanoid then
			Humanoid.Jump = true
		end
	end
end)

local UserInterface = loadstring(game:HttpGet('http://impulse-hub.xyz/library',true))():Init(game:GetService('CoreGui'), 'Impulse Hub')

local Top = UserInterface:AddTab('Neo-Wolves')
local Tab1 = Top:AddSection('Gun Settings', true)
local Tab2 = Top:AddSection('Misc', true)

local Mods = nil
local IYInjected = false
local ESPInjected = false
local AutoBuyEnabled = false

local function SetMods()
	for _, Gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
		for Prop, Value in pairs(Mods) do
			if Gun[Prop] then
				Gun[Prop] = Value
			end
		end
	end
end

Tab1:AddButton('GunMods', 'Enable', true, function()
	Mods = {
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
	SetMods()
end)

Tab1:AddToggle('AutoBuy', 'Auto Buy Ammo', false, function(Value)
	AutoBuyEnabled = Value
end)

Tab1:AddTextLabel('AutoBuyDisclaimer', 'You have to run through the store to buy ammo', true)

Tab2:AddButton('Open', 'Open Impulse IY', true, function()
    if not IYInjected then
    	IYInjected = true
	loadstring(game:HttpGet('http://impulse-hub.xyz/ImpulseHub',true))()
    end
end)

Tab2:AddButton('OpenESP', 'Open ESP', true, function()
    if not ESPInjected then
    	ESPInjected = true
	loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()
    end
end)

while wait(0.5) do
	if AutoBuyEnabled then
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("PistolAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("RifleAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("ShotgunAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("Dynamite",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("SniperAmmo",true)
		game:GetService("ReplicatedStorage").GeneralEvents.BuyItem:InvokeServer("BIG Dynamite",true)
	end
end

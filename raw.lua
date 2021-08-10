local UserInterface = loadstring(game:HttpGet('http://impulse-hub.xyz/library',true))():Init(game:GetService('CoreGui'), 'Impulse Hub')

local Top = UserInterface:AddTab('Neo-Wolves')
local Tab1 = Top:AddSection('Gun Mods', true)
local Tab2 = Top:AddSection('Misc', true)

local Mods = nil
local IYInjected = false

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

Tab2:AddButton('Open', 'Open Impulse IY', true, function()
    if not IYInjected then
      IYInjected = true
	    loadstring(game:HttpGet('http://impulse-hub.xyz/ImpulseHub',true))()
    end
end)

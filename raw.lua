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
local UILibrary = require(script.Parent.UILibrary)

local Menu = UILibrary.AddMenu()
local GunMods = UILibrary.AddButton(Menu[1], 'Gun Mods', 'Disabled')
local AutoBuySell = UILibrary.AddButton(Menu[1], 'Auto Buy/ Sell', 'Disabled')
local AutoHeal = UILibrary.AddButton(Menu[1], 'Auto Heal', 'Disabled')
local ESPAdmin = UILibrary.AddButton(Menu[1], 'Launch ESP/ Admin', 'Launch')


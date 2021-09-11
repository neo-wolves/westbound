local module = {}
local Player = game.Players.LocalPlayer

module.AddMenu = function()
	-- Create Screen UI
	local UIMain = Instance.new('ScreenGui', Player.PlayerGui)
	UIMain.ResetOnSpawn = false
	
	-- Create Frame for Menu
	local MainFrame = Instance.new('ImageLabel', UIMain)
	MainFrame.BackgroundTransparency = 1
	MainFrame.Position = UDim2.fromScale(0.91, 0.165)
	MainFrame.Size = UDim2.fromScale(0.082, 0.186)
	MainFrame.Image = 'rbxassetid://4989051704'
	MainFrame.ImageColor3 = Color3.fromRGB(255, 191, 139)
	MainFrame.ImageTransparency = 0.3
	MainFrame.ScaleType = Enum.ScaleType.Slice
	MainFrame.SliceCenter = Rect.new(41, 41, 50, 60)
	MainFrame.SliceScale = 0.4
	MainFrame.Draggable = true
	MainFrame.Active = true
	MainFrame.Selectable = true
	
	-- Create Title for Frame
	local Title = Instance.new('ImageLabel', MainFrame)
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.fromScale(0, -0.058)
	Title.Size = UDim2.fromScale(1, 0.204)
	Title.Image = 'rbxassetid://4989051704'
	Title.ImageColor3 = Color3.fromRGB(255, 191, 139)
	Title.ImageTransparency = 0.1
	Title.ScaleType = Enum.ScaleType.Slice
	Title.SliceCenter = Rect.new(41, 41, 50, 60)
	Title.SliceScale = 0.4
	Title.ZIndex = 2
	
	-- Create Text for Title
	local TitleText = Instance.new('TextLabel', Title)
	TitleText.BackgroundTransparency = 1
	TitleText.Position = UDim2.fromScale(0.173, 0.223)
	TitleText.Size = UDim2.fromScale(0.648, 0.543)
	TitleText.Font = Enum.Font.SourceSansItalic
	TitleText.TextColor3 = Color3.fromRGB(255, 246, 219)
	TitleText.TextScaled = true
	TitleText.TextStrokeTransparency = 0
	TitleText.TextWrapped = true
	TitleText.Text = 'Neo Wolves'
	TitleText.ZIndex = 3
	
	-- Create ScrollFrame for MainFrame
	local ScrollFrame = Instance.new('ScrollingFrame', MainFrame)
	ScrollFrame.BackgroundTransparency = 1
	ScrollFrame.Position = UDim2.fromScale(0.076, 0.173)
	ScrollFrame.Size = UDim2.fromScale(0.848, 0.781)
	ScrollFrame.ScrollBarImageTransparency = 1
	ScrollFrame.ScrollBarThickness = 0
	
	-- Create Layout for ScrollFrame
	local Layout = Instance.new('UIGridLayout', ScrollFrame)
	Layout.CellPadding = UDim2.fromOffset(5, 10)
	Layout.CellSize = UDim2.fromScale(0.98, 0.11)
	
	return(ScrollFrame)
end

module.AddButton = function(Menu, Title, ButtonTitle)
	-- Create Frame for Menu
	local MainFrame = Instance.new('Frame', Menu)
	MainFrame.BackgroundTransparency = 1
	
	-- Create Title for Frame
	local TitleText = Instance.new('TextLabel', MainFrame)
	TitleText.BackgroundTransparency = 1
	TitleText.Size = UDim2.fromScale(1, 0.382)
	TitleText.Font = Enum.Font.SourceSansItalic
	TitleText.TextColor3 = Color3.fromRGB(255, 191, 139)
	TitleText.TextScaled = true
	TitleText.TextStrokeTransparency = 0
	TitleText.TextWrapped = true
	TitleText.Text = Title
	TitleText.ZIndex = 3
	
	-- Create Constraint for Title
	local Constraint = Instance.new('UITextSizeConstraint', TitleText)
	Constraint.MaxTextSize = 26
	
	-- Create Button for Frame
	local Button = Instance.new('ImageButton', MainFrame)
	Button.AnchorPoint = Vector2.new(0.5, 0)
	Button.BackgroundTransparency = 1
	Button.Position = UDim2.fromScale(0.496, 0.402)
	Button.Size = UDim2.fromScale(1, 0.744)
	Button.Image = 'rbxassetid://6496473447'
	Button.PressedImage = 'rbxassetid://6496473923'
	Button.ImageColor3 = Color3.fromRGB(255, 191, 139)
	Button.ScaleType = Enum.ScaleType.Slice
	Button.SliceCenter = Rect.new(41, 41, 50, 60)
	Button.SliceScale = 0.4
	Button.ZIndex = 3
	
	-- Create ButtonTitle for Button
	local ButtonTitleText = Instance.new('TextLabel', Button)
	ButtonTitleText.BackgroundTransparency = 1
	ButtonTitleText.Position = UDim2.fromScale(0.1, 0.168)
	ButtonTitleText.Size = UDim2.fromScale(0.796, 0.649)
	ButtonTitleText.Font = Enum.Font.SourceSansItalic
	ButtonTitleText.TextColor3 = Color3.fromRGB(255, 191, 139)
	ButtonTitleText.TextScaled = true
	ButtonTitleText.TextStrokeTransparency = 0
	ButtonTitleText.TextWrapped = true
	ButtonTitleText.Text = ButtonTitle
	ButtonTitleText.ZIndex = 3
	
	return(Button)
end

return module

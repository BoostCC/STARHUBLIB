
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local libary = {}
local Windows = {}
local CurrentWindow = nil
local CurrentTab = nil
local Sections = {left = {}, right = {}}
local Dragging = false
local DragStart = nil
local DragStartPosition = nil
local libary_footer_text = {}
local libary_bottom_text = {}

local libary_config = {
    ToggleState = {},
    SliderProgress = {},
    TextInputValue = {},
    DropdownSelectedValues = {},
    DropdownValue = {},
    ConfigName = {},
    KeybindValue = {},
    ColorPickerValue = {},
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CharlieWareUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.ClipsDescendants = true
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 563, 0, 400)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Parent = ScreenGui

local Header = Instance.new("Frame")
Header.AnchorPoint = Vector2.new(0.5, 0)
Header.Name = "Header"
Header.Position = UDim2.new(0.5, 0, 0, 0)
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 563, 0, 40)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.Parent = MainFrame

local Libary_Name = Instance.new("TextLabel")
Libary_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Libary_Name.TextStrokeTransparency = 0.800000011920929
Libary_Name.AnchorPoint = Vector2.new(0, 0.5)
Libary_Name.TextSize = 15
Libary_Name.Size = UDim2.new(0, 1, 0, 1)
Libary_Name.RichText = true
Libary_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Libary_Name.Text = 'examplelibary<font color="#7D45DC">.rbx</font>'
Libary_Name.Name = "Libary_Name"
Libary_Name.BackgroundTransparency = 1
Libary_Name.Position = UDim2.new(0, 12, 0.5, 0)
Libary_Name.TextWrapped = true
Libary_Name.BorderSizePixel = 0
Libary_Name.AutomaticSize = Enum.AutomaticSize.XY
Libary_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.Parent = Header

local Container = Instance.new("Frame")
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.AnchorPoint = Vector2.new(1, 0.5)
Container.BackgroundTransparency = 12
Container.Position = UDim2.new(1, 0, 0.5, 0)
Container.Name = "Container"
Container.Size = UDim2.new(0, 425, 0, 40)
Container.BorderSizePixel = 0
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = Header

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.Padding = UDim.new(0, 18)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

local Tab = Instance.new("Frame")
Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab.Name = "Tab"
Tab.BackgroundTransparency = 1
Tab.Position = UDim2.new(0.12941177189350128, 0, 0, 0)
Tab.Size = UDim2.new(0, 47, 0, 40)
Tab.BorderSizePixel = 0
Tab.AutomaticSize = Enum.AutomaticSize.X
Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab.Parent = Container

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 4)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Tab

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
}
UIGradient.Parent = Inline

local Tab_Name = Instance.new("TextLabel")
Tab_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Tab_Name.TextStrokeTransparency = 0.8999999761581421
Tab_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Name.TextSize = 15
Tab_Name.Size = UDim2.new(0, 1, 0, 1)
Tab_Name.RichText = true
Tab_Name.TextColor3 = Color3.fromRGB(125, 69, 220)
Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Name.Text = "Home"
Tab_Name.Name = "Tab_Name"
Tab_Name.BackgroundTransparency = 1
Tab_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Tab_Name.TextWrapped = true
Tab_Name.BorderSizePixel = 0
Tab_Name.AutomaticSize = Enum.AutomaticSize.XY
Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Name.Parent = Tab

local Tab = Instance.new("Frame")
Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab.Name = "Tab"
Tab.BackgroundTransparency = 1
Tab.Position = UDim2.new(0.12941177189350128, 0, 0, 0)
Tab.Size = UDim2.new(0, 47, 0, 40)
Tab.BorderSizePixel = 0
Tab.AutomaticSize = Enum.AutomaticSize.X
Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab.Parent = Container

local Tab_Name = Instance.new("TextLabel")
Tab_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Tab_Name.TextStrokeTransparency = 0.8999999761581421
Tab_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Name.TextSize = 15
Tab_Name.Size = UDim2.new(0, 1, 0, 1)
Tab_Name.RichText = true
Tab_Name.TextColor3 = Color3.fromRGB(169, 169, 169)
Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Name.Text = "Settings"
Tab_Name.Name = "Tab_Name"
Tab_Name.BackgroundTransparency = 1
Tab_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Tab_Name.TextWrapped = true
Tab_Name.BorderSizePixel = 0
Tab_Name.AutomaticSize = Enum.AutomaticSize.XY
Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Name.Parent = Tab

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.Parent = Container

local Footer = Instance.new("Frame")
Footer.AnchorPoint = Vector2.new(0.5, 1)
Footer.Name = "Footer"
Footer.Position = UDim2.new(0.5, 0, 0.9999998211860657, 0)
Footer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Footer.Size = UDim2.new(0, 563, 0, 28)
Footer.BorderSizePixel = 0
Footer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Footer.Parent = MainFrame

local footer_left_label = Instance.new("TextLabel")
footer_left_label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
footer_left_label.TextStrokeTransparency = 0.800000011920929
footer_left_label.AnchorPoint = Vector2.new(0, 0.5)
footer_left_label.TextSize = 15
footer_left_label.Size = UDim2.new(0, 1, 0, 1)
footer_left_label.RichText = true
footer_left_label.TextColor3 = Color3.fromRGB(255, 255, 255)
footer_left_label.BorderColor3 = Color3.fromRGB(0, 0, 0)
footer_left_label.Text = "gamename"
footer_left_label.Name = "footer_left_label"
footer_left_label.BackgroundTransparency = 1
footer_left_label.Position = UDim2.new(0, 12, 0.5, 0)
footer_left_label.TextWrapped = true
footer_left_label.BorderSizePixel = 0
footer_left_label.AutomaticSize = Enum.AutomaticSize.XY
footer_left_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
footer_left_label.Parent = Footer

local Container = Instance.new("Frame")
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.AnchorPoint = Vector2.new(1, 0.5)
Container.Name = "Container"
Container.BackgroundTransparency = 12
Container.Position = UDim2.new(1, 0, 0.5000065565109253, 0)
Container.Size = UDim2.new(0, 105, 0, 28)
Container.BorderSizePixel = 0
Container.AutomaticSize = Enum.AutomaticSize.XY
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = Footer

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 6)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.Parent = Container

local footer_text = Instance.new("TextLabel")
footer_text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
footer_text.TextStrokeTransparency = 0.800000011920929
footer_text.AnchorPoint = Vector2.new(1, 0.5)
footer_text.TextSize = 15
footer_text.Size = UDim2.new(0, 1, 0, 1)
footer_text.RichText = true
footer_text.TextColor3 = Color3.fromRGB(255, 255, 255)
footer_text.BorderColor3 = Color3.fromRGB(0, 0, 0)
footer_text.Text = "uptime:0:00"
footer_text.Name = "footer_text"
footer_text.BackgroundTransparency = 1
footer_text.Position = UDim2.new(0.3552631437778473, -90, -3.299999952316284, 0)
footer_text.TextWrapped = true
footer_text.BorderSizePixel = 0
footer_text.AutomaticSize = Enum.AutomaticSize.XY
footer_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
footer_text.Parent = Container

local Page = Instance.new("Frame")
Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
Page.AnchorPoint = Vector2.new(0.5, 1)
Page.BackgroundTransparency = 1
Page.Position = UDim2.new(0.5, 0, 1, 0)
Page.Name = "Page"
Page.Size = UDim2.new(0, 563, 0, 360)
Page.BorderSizePixel = 0
Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Page.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.ScrollBarImageColor3 = Color3.fromRGB(125, 69, 220)
Container.MidImage = "rbxassetid://78742712038042"

Container.Active = true
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.Name = "Container"

Container.Size = UDim2.new(0, 563, 0, 334)
Container.TopImage = ""

Container.BackgroundTransparency = 1
Container.BottomImage = ""
Container.BorderSizePixel = 0
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = Page

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Wraps = true
UIListLayout.Padding = UDim.new(0, 16)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.Parent = Container

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Container

local Section_Left = Instance.new("Frame")
Section_Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Left.Name = "Section_Left"
Section_Left.BackgroundTransparency = 1
Section_Left.Position = UDim2.new(0.021314388141036034, 0, 0.03055555559694767, 0)
Section_Left.Size = UDim2.new(0, 260, 0, 60)
Section_Left.BorderSizePixel = 0
Section_Left.AutomaticSize = Enum.AutomaticSize.Y
Section_Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Left.Parent = Container

local Header = Instance.new("Frame")
Header.AnchorPoint = Vector2.new(0.5, 0)
Header.Name = "Header"
Header.Position = UDim2.new(0.5, 0, 0, 0)
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 260, 0, 32)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.Parent = Section_Left

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 4)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Header

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
}
UIGradient.Parent = Inline

local Holder = Instance.new("Frame")
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.AnchorPoint = Vector2.new(0.5, 0)
Holder.Name = "Holder"
Holder.BackgroundTransparency = 1
Holder.Position = UDim2.new(0.5004807710647583, 0, 1, 0)
Holder.Size = UDim2.new(0, 1, 0, 1)
Holder.BorderSizePixel = 0
Holder.AutomaticSize = Enum.AutomaticSize.XY
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.Parent = Header

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Holder

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingBottom = UDim.new(0, 35)
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.Parent = Holder

local Section_Name = Instance.new("TextLabel")
Section_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Section_Name.TextColor3 = Color3.fromRGB(125, 69, 220)
Section_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Name.Text = "ExampleSection"
Section_Name.Name = "Section_Name"
Section_Name.TextStrokeTransparency = 0.8500000238418579
Section_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Section_Name.Size = UDim2.new(0, 1, 0, 1)
Section_Name.BackgroundTransparency = 1
Section_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Section_Name.BorderSizePixel = 0
Section_Name.AutomaticSize = Enum.AutomaticSize.XY
Section_Name.TextSize = 14
Section_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Name.Parent = Header

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Section_Left

local Section_Left = Instance.new("Frame")
Section_Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Left.Name = "Section_Left"
Section_Left.BackgroundTransparency = 1
Section_Left.Position = UDim2.new(0.021314388141036034, 0, 0.03055555559694767, 0)
Section_Left.Size = UDim2.new(0, 260, 0, 60)
Section_Left.BorderSizePixel = 0
Section_Left.AutomaticSize = Enum.AutomaticSize.Y
Section_Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Left.Parent = Container

local Header = Instance.new("Frame")
Header.AnchorPoint = Vector2.new(0.5, 0)
Header.Name = "Header"
Header.Position = UDim2.new(0.5, 0, 0, 0)
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 260, 0, 32)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.Parent = Section_Left

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 4)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Header

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
}
UIGradient.Parent = Inline

local Holder = Instance.new("Frame")
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.AnchorPoint = Vector2.new(0.5, 0)
Holder.Name = "Holder"
Holder.BackgroundTransparency = 1
Holder.Position = UDim2.new(0.5004807710647583, 0, 1, 0)
Holder.Size = UDim2.new(0, 1, 0, 1)
Holder.BorderSizePixel = 0
Holder.AutomaticSize = Enum.AutomaticSize.XY
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.Parent = Header

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Holder

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingBottom = UDim.new(0, 35)
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.Parent = Holder

local Section_Name = Instance.new("TextLabel")
Section_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Section_Name.TextColor3 = Color3.fromRGB(125, 69, 220)
Section_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Name.Text = "ExampleSection"
Section_Name.Name = "Section_Name"
Section_Name.TextStrokeTransparency = 0.8500000238418579
Section_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Section_Name.Size = UDim2.new(0, 1, 0, 1)
Section_Name.BackgroundTransparency = 1
Section_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Section_Name.BorderSizePixel = 0
Section_Name.AutomaticSize = Enum.AutomaticSize.XY
Section_Name.TextSize = 14
Section_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Name.Parent = Header

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Section_Left

local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Position = UDim2.new(0, 0, 0.8083333373069763, 0)
Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
Shadow.Size = UDim2.new(0, 563, 0, 44)
Shadow.BorderSizePixel = 0
Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Shadow.Parent = Page

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.212, 0.668749988079071),
	NumberSequenceKeypoint.new(0.666, 0.22499996423721313),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
}
UIGradient.Parent = Shadow

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0.5, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0.5, 0, 1.0681846141815186, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0.06818459182977676, 1)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Shadow

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = -90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.394, 1),
	NumberSequenceKeypoint.new(0.596, 0.6812499761581421),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 65, 204)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(117, 65, 204))
}
UIGradient.Parent = Inline





local Players = game:GetService("Players")

local ACCENT = Color3.fromRGB(125, 69, 220)

function libary:SetAccentColor(color)
	ACCENT = color or ACCENT
end

function libary:CreateNotification()
	return nil
end

local function colorSequenceFrom(color)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, color),
		ColorSequenceKeypoint.new(1, color)
	})
end

local function createSectionFrame(parent, headerText)
	local section = Instance.new("Frame")
	section.Name = "Section"
	section.BackgroundTransparency = 1
	section.AutomaticSize = Enum.AutomaticSize.Y
	section.Size = UDim2.new(0, 260, 0, 60)
	section.Parent = parent

	local header = Instance.new("Frame")
	header.Name = "Header"
	header.AnchorPoint = Vector2.new(0.5, 0)
	header.Position = UDim2.new(0.5, 0, 0, 0)
	header.Size = UDim2.new(0, 260, 0, 32)
	header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	header.BorderSizePixel = 0
	header.Parent = section

	local inline = Instance.new("Frame")
	inline.Name = "Inline"
	inline.AnchorPoint = Vector2.new(0, 1)
	inline.Position = UDim2.new(0, 0, 1, 0)
	inline.Size = UDim2.new(1, 1, 0, 4)
	inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	inline.BorderSizePixel = 0
	inline.Parent = header

	local g = Instance.new("UIGradient")
	g.Rotation = 90
	g.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.436, 0.6625),
		NumberSequenceKeypoint.new(1, 0)
	})
	g.Color = colorSequenceFrom(ACCENT)
	g.Parent = inline

	local title = Instance.new("TextLabel")
	title.Name = "Section_Name"
	title.BackgroundTransparency = 1
	title.AnchorPoint = Vector2.new(0.5, 0.5)
	title.Position = UDim2.new(0.5, 0, 0.5, 0)
	title.Text = headerText or "Section"
	title.TextColor3 = ACCENT
	title.TextSize = 14
	title.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	title.Parent = header

	local holder = Instance.new("Frame")
	holder.Name = "Holder"
	holder.BackgroundTransparency = 1
	holder.AutomaticSize = Enum.AutomaticSize.Y
	holder.Size = UDim2.new(0, 1, 0, 1)
	holder.Position = UDim2.new(0.5, 0, 1, 0)
	holder.AnchorPoint = Vector2.new(0.5, 0)
	holder.Parent = header

	local holderList = Instance.new("UIListLayout")
	holderList.SortOrder = Enum.SortOrder.LayoutOrder
	holderList.Parent = holder

	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 4)
	pad.PaddingBottom = UDim.new(0, 35)
	pad.Parent = holder

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(35, 35, 35)
	stroke.Parent = section

	return section
end

function libary:CreateWindow(cfg)
	local opts = cfg or {}
	local window = {}

	local screen = ScreenGui
	local main = screen:FindFirstChild("MainFrame")
	local headerBar = main:FindFirstChild("Header")
	local footer = main:FindFirstChild("Footer")
	local page = main:FindFirstChild("Page")

	local title = headerBar:FindFirstChild("Libary_Name")
	if title then
		title.Text = string.format("%s<font color=\"#7D45DC\">.rbx</font>", opts.Libary_Name or "examplelibary")
	end

	local leftFooter = footer and footer:FindFirstChild("footer_left_label")
	if leftFooter then
		leftFooter.Text = opts.Footer_Left_Text or "gamename"
	end

	local tabsHolder = headerBar:FindFirstChild("Container")
	for _, ch in ipairs(tabsHolder:GetChildren()) do
		if ch:IsA("GuiObject") and ch.Name == "Tab" then ch:Destroy() end
	end

	for _, ch in ipairs(page:GetChildren()) do
		if ch:IsA("GuiObject") then ch:Destroy() end
	end

	local pages = Instance.new("Folder")
	pages.Name = "Pages"
	pages.Parent = page

	local function setActive(tabMeta, active)
		if active then
			tabMeta.Label.TextColor3 = ACCENT
			tabMeta.Page.Visible = true
		else
			tabMeta.Label.TextColor3 = Color3.fromRGB(169, 169, 169)
			tabMeta.Page.Visible = false
		end
	end

	window._tabs = {}
	window._active = nil

	function window:CreateTab(topt)
		local name = (topt and topt.TabText) or "Tab"

		local tab = Instance.new("Frame")
		tab.Name = "Tab"
		tab.BackgroundTransparency = 1
		tab.AutomaticSize = Enum.AutomaticSize.X
		tab.Size = UDim2.new(0, 47, 0, 40)
		tab.Parent = tabsHolder

		local underline = Instance.new("Frame")
		underline.Name = "Inline"
		underline.AnchorPoint = Vector2.new(0, 1)
		underline.Position = UDim2.new(0, 0, 1, 0)
		underline.Size = UDim2.new(1, 1, 0, 4)
		underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		underline.BorderSizePixel = 0
		underline.Parent = tab

		local ug = Instance.new("UIGradient")
		ug.Rotation = 90
		ug.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.436, 0.6625),
			NumberSequenceKeypoint.new(1, 0)
		})
		ug.Color = colorSequenceFrom(ACCENT)
		ug.Parent = underline

		local label = Instance.new("TextButton")
		label.Name = "Tab_Name"
		label.BackgroundTransparency = 1
		label.AnchorPoint = Vector2.new(0.5, 0.5)
		label.Position = UDim2.new(0.5, 0, 0.5, 0)
		label.AutomaticSize = Enum.AutomaticSize.XY
		label.Text = name
		label.TextSize = 15
		label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		label.Parent = tab

		local pageFrame = Instance.new("Frame")
		pageFrame.Name = name .. "_Page"
		pageFrame.Size = UDim2.new(1, 0, 1, -26)
		pageFrame.Position = UDim2.new(0, 0, 0, 0)
		pageFrame.BackgroundTransparency = 1
		pageFrame.Parent = pages

		local columns = Instance.new("Frame")
		columns.Name = "Columns"
		columns.BackgroundTransparency = 1
		columns.Size = UDim2.new(1, -24, 1, -26)
		columns.Position = UDim2.new(0, 12, 0, 12)
		columns.Parent = pageFrame

		local leftCol = Instance.new("Frame")
		leftCol.BackgroundTransparency = 1
		leftCol.AutomaticSize = Enum.AutomaticSize.Y
		leftCol.Size = UDim2.new(0, 260, 0, 1)
		leftCol.Parent = columns

		local rightCol = Instance.new("Frame")
		rightCol.BackgroundTransparency = 1
		rightCol.AutomaticSize = Enum.AutomaticSize.Y
		rightCol.Size = UDim2.new(0, 260, 0, 1)
		rightCol.Position = UDim2.new(0, 260 + 16, 0, 0)
		rightCol.Parent = columns

		local meta = {Label = label, Page = pageFrame, Columns = {left = leftCol, right = rightCol}}
		table.insert(self._tabs, meta)

		label.MouseButton1Click:Connect(function()
			self._active = meta
			for _, t in ipairs(self._tabs) do setActive(t, t == self._active) end
		end)

		if not self._active then
			self._active = meta
			setActive(meta, true)
		else
			setActive(meta, false)
		end

		local tabObj = {}
		function tabObj:CreateSection(sopt)
			local pos = ((sopt and sopt.position) == "right") and "right" or "left"
			local txt = (sopt and sopt.SectionText) or "Section"
			local sec = createSectionFrame(meta.Columns[pos], txt)
			local api = {}
			function api:CreateToggle() return {} end
			function api:CreateSlider() return {} end
			function api:CreateLabel() return {} end
			function api:CreateTextInput() return {} end
			function api:CreateDropdown() return {} end
			function api:CreateKeybind() return {} end
			function api:CreateColorpicker() return {} end
			function api:CreateButton() return {} end
			function api:CreateConfig() return {} end
			function api:AddColorToggle() return {key = "none"} end
			function api:CreateToggleWithKeybind() return {key = "none"} end
			return api
		end

		return tabObj
	end

	function window:CreateSection(sopt)
		if not self._active then return nil end
		local pos = ((sopt and sopt.position) == "right") and "right" or "left"
		local txt = (sopt and sopt.SectionText) or "Section"
		local sec = createSectionFrame(self._active.Columns[pos], txt)
		local api = {}
		function api:CreateToggle() return {} end
		function api:CreateSlider() return {} end
		function api:CreateLabel() return {} end
		function api:CreateTextInput() return {} end
		function api:CreateDropdown() return {} end
		function api:CreateKeybind() return {} end
		function api:CreateColorpicker() return {} end
		function api:CreateButton() return {} end
		function api:CreateConfig() return {} end
		function api:AddColorToggle() return {key = "none"} end
		function api:CreateToggleWithKeybind() return {key = "none"} end
		return api
	end

	local keyName = opts.interface_keybind or "Insert"
	local keyEnum = Enum.KeyCode[keyName] or Enum.KeyCode.Insert
	local visible = true

	local fadeInInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local fadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

	local function show()
		main.Visible = true
		main.BackgroundTransparency = 1
		TweenService:Create(main, fadeInInfo, {BackgroundTransparency = 0}):Play()
	end

	local function hide()
		local t = TweenService:Create(main, fadeOutInfo, {BackgroundTransparency = 1})
		t:Play()
		t.Completed:Connect(function() main.Visible = false end)
	end

	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == keyEnum then
			visible = not visible
			if visible then show() else hide() end
		end
	end)

	local dragging = false
	local dragStart
	local startPos
	local headerInput
	local headerBarForDrag = headerBar

	headerBarForDrag.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	headerBarForDrag.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			headerInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == headerInput and dragging then
			local delta = input.Position - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	return window
end

return libary

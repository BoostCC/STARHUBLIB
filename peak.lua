-- Create ScreenGui for the UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CharliewareUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local BG_BLUR = Instance.new("Frame")
BG_BLUR.BackgroundTransparency = 0.2
BG_BLUR.Name = "BG_BLUR"
BG_BLUR.BorderColor3 = Color3.fromRGB(0, 0, 0)
BG_BLUR.Size = UDim2.new(1, 0, 1, 0)
BG_BLUR.Position = UDim2.new(0, 0, 0, 0)
BG_BLUR.AnchorPoint = Vector2.new(0, 0)
BG_BLUR.BorderSizePixel = 0
BG_BLUR.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BG_BLUR.ZIndex = 0
BG_BLUR.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.ClipsDescendants = true
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 563, 0, 400)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.ZIndex = 1
MainFrame.Parent = BG_BLUR

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

local Toggle_Componenet = Instance.new("Frame")
Toggle_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Toggle_Componenet.BackgroundTransparency = 1
Toggle_Componenet.Position = UDim2.new(0.501682698726654, 0, 0, 0)
Toggle_Componenet.Name = "Toggle_Componenet"
Toggle_Componenet.Size = UDim2.new(0, 260, 0, 30)
Toggle_Componenet.BorderSizePixel = 0
Toggle_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Componenet.Parent = Holder

local Toggle = Instance.new("Frame")
Toggle.AnchorPoint = Vector2.new(0, 0.5)
Toggle.Name = "Toggle"
Toggle.Position = UDim2.new(0, 12, 0.5, 0)
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.Size = UDim2.new(0, 16, 0, 16)
Toggle.BorderSizePixel = 0
Toggle.BackgroundColor3 = Color3.fromRGB(125, 69, 220)
Toggle.Parent = Toggle_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Toggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Toggle

local Check = Instance.new("ImageLabel")
Check.BorderColor3 = Color3.fromRGB(0, 0, 0)
Check.Name = "Check"
Check.AnchorPoint = Vector2.new(0.5, 0.5)
Check.Image = "rbxassetid://103083009202465"
Check.BackgroundTransparency = 1
Check.Position = UDim2.new(0.5, 0, 0.5, 0)

Check.Size = UDim2.new(0, 10, 0, 12)
Check.BorderSizePixel = 0
Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Check.Parent = Toggle

local Color_Frame = Instance.new("Frame")
Color_Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Color_Frame.Name = "Color_Frame"
Color_Frame.Position = UDim2.new(0.5, 225, 0.5, 0)
Color_Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Color_Frame.Size = UDim2.new(0, 15, 0, 15)
Color_Frame.BorderSizePixel = 0
Color_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Color_Frame.Parent = Toggle

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Color_Frame

local Toggle_Text = Instance.new("TextLabel")
Toggle_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Toggle_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Text.Text = "ExampleToggle"
Toggle_Text.Name = "Toggle_Text"
Toggle_Text.AnchorPoint = Vector2.new(0, 0.5)
Toggle_Text.Size = UDim2.new(0, 1, 0, 1)
Toggle_Text.BackgroundTransparency = 1
Toggle_Text.Position = UDim2.new(0, 35, 0.5, 0)
Toggle_Text.BorderSizePixel = 0
Toggle_Text.AutomaticSize = Enum.AutomaticSize.XY
Toggle_Text.TextSize = 14
Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.Parent = Toggle_Componenet

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingBottom = UDim.new(0, 35)
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.Parent = Holder

local Toggle_Componenet = Instance.new("Frame")
Toggle_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Toggle_Componenet.BackgroundTransparency = 1
Toggle_Componenet.Position = UDim2.new(0.501682698726654, 0, 0, 0)
Toggle_Componenet.Name = "Toggle_Componenet"
Toggle_Componenet.Size = UDim2.new(0, 260, 0, 30)
Toggle_Componenet.BorderSizePixel = 0
Toggle_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Componenet.Parent = Holder

local Toggle = Instance.new("Frame")
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.AnchorPoint = Vector2.new(0, 0.5)
Toggle.BackgroundTransparency = 1
Toggle.Position = UDim2.new(0, 12, 0.5, 0)
Toggle.Name = "Toggle"
Toggle.Size = UDim2.new(0, 16, 0, 16)
Toggle.BorderSizePixel = 0
Toggle.BackgroundColor3 = Color3.fromRGB(125, 69, 220)
Toggle.Parent = Toggle_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Toggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Toggle

local Toggle_Text = Instance.new("TextLabel")
Toggle_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Toggle_Text.TextColor3 = Color3.fromRGB(169, 169, 169)
Toggle_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Text.Text = "ExampleToggle"
Toggle_Text.Name = "Toggle_Text"
Toggle_Text.AnchorPoint = Vector2.new(0, 0.5)
Toggle_Text.Size = UDim2.new(0, 1, 0, 1)
Toggle_Text.BackgroundTransparency = 1
Toggle_Text.Position = UDim2.new(0, 35, 0.5, 0)
Toggle_Text.BorderSizePixel = 0
Toggle_Text.AutomaticSize = Enum.AutomaticSize.XY
Toggle_Text.TextSize = 14
Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.Parent = Toggle_Componenet

local Keybind_Holder = Instance.new("Frame")
Keybind_Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind_Holder.AnchorPoint = Vector2.new(1, 0.5)
Keybind_Holder.Name = "Keybind_Holder"
Keybind_Holder.BackgroundTransparency = 1
Keybind_Holder.Position = UDim2.new(1, -8, 0.5, 0)
Keybind_Holder.Size = UDim2.new(0, 20, 0, 20)
Keybind_Holder.BorderSizePixel = 0
Keybind_Holder.AutomaticSize = Enum.AutomaticSize.X
Keybind_Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Keybind_Holder.Parent = Toggle_Componenet

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Keybind_Holder

local Keybind = Instance.new("TextLabel")
Keybind.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Keybind.TextColor3 = Color3.fromRGB(169, 169, 169)
Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind.Text = "none"
Keybind.Name = "Keybind"
Keybind.Size = UDim2.new(0, 1, 0, 1)
Keybind.AnchorPoint = Vector2.new(0.30000001192092896, 0.5)
Keybind.BorderSizePixel = 0
Keybind.BackgroundTransparency = 1
Keybind.Position = UDim2.new(0.4000000059604645, 0, 0.5, 0)
Keybind.AutomaticSize = Enum.AutomaticSize.XY
Keybind.TextYAlignment = Enum.TextYAlignment.Bottom
Keybind.TextSize = 14
Keybind.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Keybind.Parent = Keybind_Holder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Keybind

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Keybind

local Dropdown_Componenet = Instance.new("Frame")
Dropdown_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Dropdown_Componenet.BackgroundTransparency = 1
Dropdown_Componenet.Position = UDim2.new(0.5, 0, 0.6206896305084229, 0)
Dropdown_Componenet.Name = "Dropdown_Componenet"
Dropdown_Componenet.Size = UDim2.new(0, 260, 0, 55)
Dropdown_Componenet.BorderSizePixel = 0
Dropdown_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Componenet.Parent = Holder

local Dropdown_Holder = Instance.new("Frame")
Dropdown_Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Holder.AnchorPoint = Vector2.new(1, 0.5)
Dropdown_Holder.Name = "Dropdown_Holder"
Dropdown_Holder.Position = UDim2.new(1, -8, 0.699999988079071, 0)
Dropdown_Holder.Size = UDim2.new(0, 240, 0, 25)
Dropdown_Holder.BorderSizePixel = 0
Dropdown_Holder.AutomaticSize = Enum.AutomaticSize.X
Dropdown_Holder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Dropdown_Holder.Parent = Dropdown_Componenet

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Dropdown_Holder

local Options = Instance.new("TextLabel")
Options.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Options.TextColor3 = Color3.fromRGB(169, 169, 169)
Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
Options.Text = "none"
Options.Name = "Options"
Options.Size = UDim2.new(0, 1, 0, 1)
Options.AnchorPoint = Vector2.new(0.30000001192092896, 0.5)
Options.BorderSizePixel = 0
Options.BackgroundTransparency = 1
Options.Position = UDim2.new(0.10000000149011612, -12, 0.5, 0)
Options.AutomaticSize = Enum.AutomaticSize.XY
Options.TextYAlignment = Enum.TextYAlignment.Bottom
Options.TextSize = 14
Options.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Options.Parent = Dropdown_Holder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Options

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Options

local Icon = Instance.new("ImageLabel")
Icon.ImageColor3 = Color3.fromRGB(70, 70, 70)
Icon.ScaleType = Enum.ScaleType.Fit
Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon.Name = "Icon"
Icon.AnchorPoint = Vector2.new(1, 0.5)
Icon.Image = "rbxassetid://120617795376272"
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0.9539749026298523, 0, 0.5, 0)

Icon.Size = UDim2.new(0, 8, 0, 8)
Icon.BorderSizePixel = 0
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.Parent = Dropdown_Holder

local Dropdown_Label = Instance.new("TextLabel")
Dropdown_Label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Dropdown_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Label.Text = "Example Dropdown"
Dropdown_Label.Name = "Dropdown_Label"
Dropdown_Label.AnchorPoint = Vector2.new(0, 0.5)
Dropdown_Label.Size = UDim2.new(0, 1, 0, 1)
Dropdown_Label.BackgroundTransparency = 1
Dropdown_Label.Position = UDim2.new(0, 12, 0.20000000298023224, 0)
Dropdown_Label.BorderSizePixel = 0
Dropdown_Label.AutomaticSize = Enum.AutomaticSize.XY
Dropdown_Label.TextSize = 14
Dropdown_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Label.Parent = Dropdown_Componenet

local Toggle_Componenet = Instance.new("Frame")
Toggle_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Toggle_Componenet.BackgroundTransparency = 1
Toggle_Componenet.Position = UDim2.new(0.501682698726654, 0, 0, 0)
Toggle_Componenet.Name = "Toggle_Componenet"
Toggle_Componenet.Size = UDim2.new(0, 260, 0, 30)
Toggle_Componenet.BorderSizePixel = 0
Toggle_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Componenet.Parent = Holder

local Toggle_Text = Instance.new("TextLabel")
Toggle_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Toggle_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Text.Text = "ExampleToggle"
Toggle_Text.Name = "Toggle_Text"
Toggle_Text.AnchorPoint = Vector2.new(0, 0.5)
Toggle_Text.Size = UDim2.new(0, 1, 0, 1)
Toggle_Text.BackgroundTransparency = 1
Toggle_Text.Position = UDim2.new(0, 12, 0.5, 0)
Toggle_Text.BorderSizePixel = 0
Toggle_Text.AutomaticSize = Enum.AutomaticSize.XY
Toggle_Text.TextSize = 14
Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.Parent = Toggle_Componenet

local Color_Frame = Instance.new("Frame")
Color_Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Color_Frame.Name = "Color_Frame"
Color_Frame.Position = UDim2.new(0.5, 115, 0.5, 0)
Color_Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Color_Frame.Size = UDim2.new(0, 15, 0, 15)
Color_Frame.BorderSizePixel = 0
Color_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Color_Frame.Parent = Toggle_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Color_Frame

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

local Config_Componenet = Instance.new("Frame")
Config_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Config_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Config_Componenet.BackgroundTransparency = 1
Config_Componenet.Position = UDim2.new(0.5, 0, 0.1435406655073166, 0)
Config_Componenet.Name = "Config_Componenet"
Config_Componenet.Size = UDim2.new(0, 260, 0, 120)
Config_Componenet.BorderSizePixel = 0
Config_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Config_Componenet.Parent = Holder

local Config_Path = Instance.new("TextLabel")
Config_Path.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Config_Path.TextColor3 = Color3.fromRGB(169, 169, 169)
Config_Path.BorderColor3 = Color3.fromRGB(0, 0, 0)
Config_Path.Text = "Config Path"
Config_Path.Name = "Config_Path"
Config_Path.AnchorPoint = Vector2.new(0, 0.5)
Config_Path.Size = UDim2.new(0, 1, 0, 1)
Config_Path.BackgroundTransparency = 1
Config_Path.Position = UDim2.new(0, 12, 0.10000000149011612, 0)
Config_Path.BorderSizePixel = 0
Config_Path.AutomaticSize = Enum.AutomaticSize.XY
Config_Path.TextSize = 14
Config_Path.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Config_Path.Parent = Config_Componenet

local Keybind_Holder = Instance.new("Frame")
Keybind_Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind_Holder.AnchorPoint = Vector2.new(0, 1)
Keybind_Holder.Name = "Keybind_Holder"
Keybind_Holder.Position = UDim2.new(0, 12, 1, -35)
Keybind_Holder.Size = UDim2.new(0, 121, 0, 25)
Keybind_Holder.BorderSizePixel = 0
Keybind_Holder.AutomaticSize = Enum.AutomaticSize.X
Keybind_Holder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Keybind_Holder.Parent = Config_Componenet

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Keybind_Holder

local Save_Button = Instance.new("TextLabel")
Save_Button.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Save_Button.TextColor3 = Color3.fromRGB(169, 169, 169)
Save_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
Save_Button.Text = "Save"
Save_Button.Name = "Save_Button"
Save_Button.Size = UDim2.new(0, 1, 0, 1)
Save_Button.AnchorPoint = Vector2.new(0.5, 0.5)
Save_Button.BorderSizePixel = 0
Save_Button.BackgroundTransparency = 1
Save_Button.Position = UDim2.new(0.5, 0, 0.5, 0)
Save_Button.AutomaticSize = Enum.AutomaticSize.XY
Save_Button.TextYAlignment = Enum.TextYAlignment.Bottom
Save_Button.TextSize = 14
Save_Button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Save_Button.Parent = Keybind_Holder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Save_Button

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Save_Button

local Dropdown_Holder = Instance.new("Frame")
Dropdown_Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Holder.AnchorPoint = Vector2.new(1, 0.5)
Dropdown_Holder.Name = "Dropdown_Holder"
Dropdown_Holder.Position = UDim2.new(1, -8, 0.3499999940395355, 0)
Dropdown_Holder.Size = UDim2.new(0, 240, 0, 25)
Dropdown_Holder.BorderSizePixel = 0
Dropdown_Holder.AutomaticSize = Enum.AutomaticSize.X
Dropdown_Holder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Dropdown_Holder.Parent = Config_Componenet

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Dropdown_Holder

local Options = Instance.new("TextLabel")
Options.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Options.TextColor3 = Color3.fromRGB(169, 169, 169)
Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
Options.Text = "none"
Options.Name = "Options"
Options.Size = UDim2.new(0, 1, 0, 1)
Options.AnchorPoint = Vector2.new(0.30000001192092896, 0.5)
Options.BorderSizePixel = 0
Options.BackgroundTransparency = 1
Options.Position = UDim2.new(0.10000000149011612, -12, 0.5, 0)
Options.AutomaticSize = Enum.AutomaticSize.XY
Options.TextYAlignment = Enum.TextYAlignment.Bottom
Options.TextSize = 14
Options.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Options.Parent = Dropdown_Holder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Options

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Options

local Icon = Instance.new("ImageLabel")
Icon.ImageColor3 = Color3.fromRGB(70, 70, 70)
Icon.ScaleType = Enum.ScaleType.Fit
Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon.Name = "Icon"
Icon.AnchorPoint = Vector2.new(1, 0.5)
Icon.Image = "rbxassetid://120617795376272"
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0.9539749026298523, 0, 0.5, 0)

Icon.Size = UDim2.new(0, 8, 0, 8)
Icon.BorderSizePixel = 0
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.Parent = Dropdown_Holder

local Keybind_Holder = Instance.new("Frame")
Keybind_Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind_Holder.AnchorPoint = Vector2.new(1, 1)
Keybind_Holder.Name = "Keybind_Holder"
Keybind_Holder.Position = UDim2.new(0.968999981880188, 0, 1, -35)
Keybind_Holder.Size = UDim2.new(0, 113, 0, 25)
Keybind_Holder.BorderSizePixel = 0
Keybind_Holder.AutomaticSize = Enum.AutomaticSize.X
Keybind_Holder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Keybind_Holder.Parent = Config_Componenet

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Keybind_Holder

local Load_Button = Instance.new("TextLabel")
Load_Button.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Load_Button.TextColor3 = Color3.fromRGB(169, 169, 169)
Load_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
Load_Button.Text = "Load"
Load_Button.Name = "Load_Button"
Load_Button.Size = UDim2.new(0, 1, 0, 1)
Load_Button.AnchorPoint = Vector2.new(0.5, 0.5)
Load_Button.BorderSizePixel = 0
Load_Button.BackgroundTransparency = 1
Load_Button.Position = UDim2.new(0.5, 0, 0.5, 0)
Load_Button.AutomaticSize = Enum.AutomaticSize.XY
Load_Button.TextYAlignment = Enum.TextYAlignment.Bottom
Load_Button.TextSize = 14
Load_Button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Load_Button.Parent = Keybind_Holder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Load_Button

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Load_Button

local Keybind_Holder = Instance.new("Frame")
Keybind_Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind_Holder.AnchorPoint = Vector2.new(0, 1)
Keybind_Holder.Name = "Keybind_Holder"
Keybind_Holder.Position = UDim2.new(0, 12, 1, -5)
Keybind_Holder.Size = UDim2.new(0, 240, 0, 25)
Keybind_Holder.BorderSizePixel = 0
Keybind_Holder.AutomaticSize = Enum.AutomaticSize.X
Keybind_Holder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Keybind_Holder.Parent = Config_Componenet

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Keybind_Holder

local Save_Button = Instance.new("TextLabel")
Save_Button.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Save_Button.TextColor3 = Color3.fromRGB(169, 169, 169)
Save_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
Save_Button.Text = "Delete"
Save_Button.Name = "Save_Button"
Save_Button.Size = UDim2.new(0, 1, 0, 1)
Save_Button.AnchorPoint = Vector2.new(0.5, 0.5)
Save_Button.BorderSizePixel = 0
Save_Button.BackgroundTransparency = 1
Save_Button.Position = UDim2.new(0.5, 0, 0.5, 0)
Save_Button.AutomaticSize = Enum.AutomaticSize.XY
Save_Button.TextYAlignment = Enum.TextYAlignment.Bottom
Save_Button.TextSize = 14
Save_Button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Save_Button.Parent = Keybind_Holder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Save_Button

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Save_Button

local Toggle_Componenet = Instance.new("Frame")
Toggle_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Toggle_Componenet.BackgroundTransparency = 1
Toggle_Componenet.Position = UDim2.new(0.501682698726654, 0, 0, 0)
Toggle_Componenet.Name = "Toggle_Componenet"
Toggle_Componenet.Size = UDim2.new(0, 260, 0, 30)
Toggle_Componenet.BorderSizePixel = 0
Toggle_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Componenet.Parent = Holder

local Toggle = Instance.new("Frame")
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.AnchorPoint = Vector2.new(0, 0.5)
Toggle.BackgroundTransparency = 1
Toggle.Position = UDim2.new(0, 12, 0.5, 0)
Toggle.Name = "Toggle"
Toggle.Size = UDim2.new(0, 16, 0, 16)
Toggle.BorderSizePixel = 0
Toggle.BackgroundColor3 = Color3.fromRGB(125, 69, 220)
Toggle.Parent = Toggle_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Toggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Toggle

local Toggle_Text = Instance.new("TextLabel")
Toggle_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Toggle_Text.TextColor3 = Color3.fromRGB(169, 169, 169)
Toggle_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Text.Text = "ExampleToggle"
Toggle_Text.Name = "Toggle_Text"
Toggle_Text.AnchorPoint = Vector2.new(0, 0.5)
Toggle_Text.Size = UDim2.new(0, 1, 0, 1)
Toggle_Text.BackgroundTransparency = 1
Toggle_Text.Position = UDim2.new(0, 35, 0.5, 0)
Toggle_Text.BorderSizePixel = 0
Toggle_Text.AutomaticSize = Enum.AutomaticSize.XY
Toggle_Text.TextSize = 14
Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.Parent = Toggle_Componenet

local Keybind_Holder = Instance.new("Frame")
Keybind_Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind_Holder.AnchorPoint = Vector2.new(1, 0.5)
Keybind_Holder.Name = "Keybind_Holder"
Keybind_Holder.BackgroundTransparency = 1
Keybind_Holder.Position = UDim2.new(1, -8, 0.5, 0)
Keybind_Holder.Size = UDim2.new(0, 20, 0, 20)
Keybind_Holder.BorderSizePixel = 0
Keybind_Holder.AutomaticSize = Enum.AutomaticSize.X
Keybind_Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Keybind_Holder.Parent = Toggle_Componenet

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(26, 26, 26)
UIStroke.Parent = Keybind_Holder

local Keybind = Instance.new("TextLabel")
Keybind.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Keybind.TextColor3 = Color3.fromRGB(169, 169, 169)
Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind.Text = "none"
Keybind.Name = "Keybind"
Keybind.Size = UDim2.new(0, 1, 0, 1)
Keybind.AnchorPoint = Vector2.new(0.30000001192092896, 0.5)
Keybind.BorderSizePixel = 0
Keybind.BackgroundTransparency = 1
Keybind.Position = UDim2.new(0.4000000059604645, 0, 0.5, 0)
Keybind.AutomaticSize = Enum.AutomaticSize.XY
Keybind.TextYAlignment = Enum.TextYAlignment.Bottom
Keybind.TextSize = 14
Keybind.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Keybind.Parent = Keybind_Holder

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 2)
UICorner.Parent = Keybind

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 3)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Keybind

local Slider_Componenet = Instance.new("Frame")
Slider_Componenet.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Componenet.AnchorPoint = Vector2.new(0.5, 0)
Slider_Componenet.BackgroundTransparency = 1
Slider_Componenet.Position = UDim2.new(0.48557689785957336, 0, 0.8571428656578064, 0)
Slider_Componenet.Name = "Slider_Componenet"
Slider_Componenet.Size = UDim2.new(0, 252, 0, 35)
Slider_Componenet.BorderSizePixel = 0
Slider_Componenet.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Componenet.Parent = Holder

local Slider_Label = Instance.new("TextLabel")
Slider_Label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Slider_Label.TextColor3 = Color3.fromRGB(169, 169, 169)
Slider_Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Label.Text = "Slider"
Slider_Label.Name = "Slider_Label"
Slider_Label.Size = UDim2.new(0, 1, 0, 1)
Slider_Label.BackgroundTransparency = 1
Slider_Label.Position = UDim2.new(0, 12, 0, 0)
Slider_Label.BorderSizePixel = 0
Slider_Label.AutomaticSize = Enum.AutomaticSize.XY
Slider_Label.TextSize = 14
Slider_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Label.Parent = Slider_Componenet

local Slider_BG = Instance.new("Frame")
Slider_BG.AnchorPoint = Vector2.new(0.5, 1)
Slider_BG.Name = "Slider_BG"
Slider_BG.Position = UDim2.new(0.52182537317276, 0, 1, -10)
Slider_BG.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_BG.Size = UDim2.new(0, 239, 0, 2)
Slider_BG.BorderSizePixel = 0
Slider_BG.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Slider_BG.Parent = Slider_Componenet

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 50)
UICorner.Parent = Slider_BG

local Slider_Progress = Instance.new("Frame")
Slider_Progress.AnchorPoint = Vector2.new(0, 0.5)
Slider_Progress.Name = "Slider_Progress"
Slider_Progress.Position = UDim2.new(0, 0, 0.5, 0)
Slider_Progress.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Progress.Size = UDim2.new(0, 116, 0, 2)
Slider_Progress.BorderSizePixel = 0
Slider_Progress.BackgroundColor3 = Color3.fromRGB(125, 69, 220)
Slider_Progress.Parent = Slider_BG

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 50)
UICorner.Parent = Slider_Progress

local Pointer = Instance.new("Frame")
Pointer.AnchorPoint = Vector2.new(1, 0.5)
Pointer.Name = "Pointer"
Pointer.Position = UDim2.new(1, 0, 0.5, 0)
Pointer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Pointer.Size = UDim2.new(0, 12, 0, 12)
Pointer.BorderSizePixel = 0
Pointer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pointer.Parent = Slider_Progress

local UICorner = Instance.new("UICorner")
UICorner.Parent = Pointer

local Slider_Value = Instance.new("TextLabel")
Slider_Value.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Slider_Value.TextColor3 = Color3.fromRGB(169, 169, 169)
Slider_Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Value.Text = "100"
Slider_Value.Name = "Slider_Value"
Slider_Value.AnchorPoint = Vector2.new(1, 0)
Slider_Value.Size = UDim2.new(0, 1, 0, 1)
Slider_Value.BackgroundTransparency = 1
Slider_Value.Position = UDim2.new(1, -2, 0, 0)
Slider_Value.BorderSizePixel = 0
Slider_Value.AutomaticSize = Enum.AutomaticSize.XY
Slider_Value.TextSize = 14
Slider_Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Value.Parent = Slider_Componenet

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
Inline.ZIndex = 50

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

local Libary_Bottom_Text = Instance.new("Frame")
Libary_Bottom_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Libary_Bottom_Text.AnchorPoint = Vector2.new(0, 1)
Libary_Bottom_Text.Name = "Libary_Bottom_Text"
Libary_Bottom_Text.BackgroundTransparency = 12
Libary_Bottom_Text.Position = UDim2.new(0, 15, 1, -10)
Libary_Bottom_Text.Size = UDim2.new(0, 105, 0, 28)
Libary_Bottom_Text.BorderSizePixel = 0
Libary_Bottom_Text.AutomaticSize = Enum.AutomaticSize.XY
Libary_Bottom_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Libary_Bottom_Text.Parent = BG_BLUR

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Libary_Bottom_Text

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 6)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.Parent = Libary_Bottom_Text

local example_text = Instance.new("TextLabel")
example_text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
example_text.TextStrokeTransparency = 0.800000011920929
example_text.AnchorPoint = Vector2.new(1, 0.5)
example_text.TextSize = 15
example_text.Size = UDim2.new(0, 1, 0, 1)
example_text.RichText = true
example_text.TextColor3 = Color3.fromRGB(255, 255, 255)
example_text.BorderColor3 = Color3.fromRGB(0, 0, 0)
example_text.Text = "Menu:Insert"
example_text.Name = "example_text"
example_text.BackgroundTransparency = 1
example_text.Position = UDim2.new(0.9928951859474182, -8, -1, 0)
example_text.TextWrapped = true
example_text.BorderSizePixel = 0
example_text.AutomaticSize = Enum.AutomaticSize.XY
example_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
example_text.Parent = Libary_Bottom_Text

-- Tab and Section Creation Functions
local function CreateTab(options)
    local tabText = options.TabText or "Tab"
    
    local tab = Instance.new("TextButton")
    tab.Name = tabText
    tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tab.BorderSizePixel = 0
    tab.Size = UDim2.new(0, 100, 0, 30)
    tab.Text = tabText
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 14
    tab.Font = Enum.Font.Gotham
    tab.Parent = TabContainer
    
    -- Tab click functionality
    tab.MouseButton1Click:Connect(function()
        -- Hide all pages
        for _, page in pairs(PageContainer:GetChildren()) do
            if page:IsA("Frame") then
                page.Visible = false
            end
        end
        
        -- Show corresponding page
        local pageName = tabText .. "_Page"
        local page = PageContainer:FindFirstChild(pageName)
        if page then
            page.Visible = true
        end
    end)
    
    return tab
end

local function CreateSection(options)
    local sectionText = options.SectionText or "Section"
    local position = options.position or "left"
    
    local section = Instance.new("Frame")
    section.Name = sectionText
    section.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    section.BorderSizePixel = 0
    section.Size = UDim2.new(0, 260, 0, 60)
    section.Parent = Container
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 32)
    header.Parent = section
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Text = sectionText
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 14
    title.Font = Enum.Font.Gotham
    title.Parent = header
    
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, 0, 1, -32)
    content.Position = UDim2.new(0, 0, 0, 32)
    content.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = content
    
    return section
end

-- Make UI toggleable with Insert key
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local isVisible = true

local function toggleUI()
    isVisible = not isVisible
    local targetTransparency = isVisible and 0 or 1
    local targetSize = isVisible and UDim2.new(0, 563, 0, 400) or UDim2.new(0, 0, 0, 0)
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    local tween1 = TweenService:Create(MainFrame, tweenInfo, {
        Size = targetSize,
        BackgroundTransparency = targetTransparency
    })
    
    local tween2 = TweenService:Create(BG_BLUR, tweenInfo, {
        BackgroundTransparency = isVisible and 0.2 or 1
    })
    
    -- Hide/show the Libary_Bottom_Text frame
    Libary_Bottom_Text.Visible = isVisible
    
    local tween3 = TweenService:Create(example_text, tweenInfo, {
        TextTransparency = isVisible and 0 or 1
    })
    
    tween1:Play()
    tween2:Play()
    tween3:Play()
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
end)

-- Example usage of tab and section creation


print("CHARLIEWARE UI Loaded! Press Insert to toggle.")
print("Tab and Section creation functions are now available!")


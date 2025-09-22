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

-- Library functions
function libary:CreateWindow(options)
    local window = {}
    local tabs = {}
    local currentTabIndex = 1
    
    -- Set window title and footer
    if options.Libary_Name then
        Libary_Name.Text = options.Libary_Name .. '<font color="#7D45DC">.rbx</font>'
    end
    
    if options.Footer_Left_Text then
        footer_left_label.Text = options.Footer_Left_Text
    end
    
    -- Set up keybind for interface toggle
    if options.interface_keybind then
        local keybindEnum = Enum.KeyCode[options.interface_keybind]
        if keybindEnum then
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                if input.KeyCode == keybindEnum then
                    toggleUI()
                end
            end)
        end
    end
    
    -- Window methods
    function window:CreateTab(tabOptions)
        local tab = {}
        local tabIndex = #tabs + 1
        tabs[tabIndex] = tab
        
        -- Create tab UI element
        local tabFrame = Instance.new("Frame")
        tabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        tabFrame.Name = "Tab"
        tabFrame.BackgroundTransparency = 1
        tabFrame.Size = UDim2.new(0, 47, 0, 40)
        tabFrame.BorderSizePixel = 0
        tabFrame.AutomaticSize = Enum.AutomaticSize.X
        tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabFrame.Parent = Container
        
        local tabName = Instance.new("TextLabel")
        tabName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        tabName.TextStrokeTransparency = 0.8999999761581421
        tabName.AnchorPoint = Vector2.new(0.5, 0.5)
        tabName.TextSize = 15
        tabName.Size = UDim2.new(0, 1, 0, 1)
        tabName.RichText = true
        tabName.TextColor3 = Color3.fromRGB(169, 169, 169)
        tabName.BorderColor3 = Color3.fromRGB(0, 0, 0)
        tabName.Text = tabOptions.TabText or "Tab"
        tabName.Name = "Tab_Name"
        tabName.BackgroundTransparency = 1
        tabName.Position = UDim2.new(0.5, 0, 0.5, 0)
        tabName.TextWrapped = true
        tabName.BorderSizePixel = 0
        tabName.AutomaticSize = Enum.AutomaticSize.XY
        tabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabName.Parent = tabFrame
        
        -- Create inline indicator for active tab
        if tabIndex == 1 then
            local inline = Instance.new("Frame")
            inline.AnchorPoint = Vector2.new(0, 1)
            inline.Name = "Inline"
            inline.Position = UDim2.new(0, 0, 1, 0)
            inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
            inline.Size = UDim2.new(1, 1, 0, 4)
            inline.BorderSizePixel = 0
            inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            inline.Parent = tabFrame
            
            local uiGradient = Instance.new("UIGradient")
            uiGradient.Rotation = 90
            uiGradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
                NumberSequenceKeypoint.new(1, 0)
            }
            uiGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
            }
            uiGradient.Parent = inline
            
            tabName.TextColor3 = Color3.fromRGB(125, 69, 220)
        end
        
        -- Tab click functionality
        tabFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                -- Switch to this tab
                currentTabIndex = tabIndex
                CurrentTab = tab
                
                -- Update all tab appearances
                for i, t in pairs(tabs) do
                    local frame = Container:FindFirstChild("Tab")
                    if frame then
                        local name = frame:FindFirstChild("Tab_Name")
                        local inline = frame:FindFirstChild("Inline")
                        
                        if i == tabIndex then
                            if name then name.TextColor3 = Color3.fromRGB(125, 69, 220) end
                            if not inline then
                                inline = Instance.new("Frame")
                                inline.AnchorPoint = Vector2.new(0, 1)
                                inline.Name = "Inline"
                                inline.Position = UDim2.new(0, 0, 1, 0)
                                inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
                                inline.Size = UDim2.new(1, 1, 0, 4)
                                inline.BorderSizePixel = 0
                                inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                inline.Parent = frame
                                
                                local uiGradient = Instance.new("UIGradient")
                                uiGradient.Rotation = 90
                                uiGradient.Transparency = NumberSequence.new{
                                    NumberSequenceKeypoint.new(0, 1),
                                    NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
                                    NumberSequenceKeypoint.new(1, 0)
                                }
                                uiGradient.Color = ColorSequence.new{
                                    ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
                                    ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
                                }
                                uiGradient.Parent = inline
                            end
                        else
                            if name then name.TextColor3 = Color3.fromRGB(169, 169, 169) end
                            if inline then inline:Destroy() end
                        end
                    end
                end
            end
        end)
        
        -- Tab methods
        function tab:CreateSection(sectionOptions)
            local section = {}
            local position = sectionOptions.position or "left"
            local sectionText = sectionOptions.SectionText or "Section"
            
            -- Create section frame
            local sectionFrame = Instance.new("Frame")
            sectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            sectionFrame.Name = "Section_" .. position:sub(1,1):upper() .. position:sub(2)
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.Size = UDim2.new(0, 260, 0, 60)
            sectionFrame.BorderSizePixel = 0
            sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            sectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionFrame.Parent = Container
            
            -- Create section header
            local header = Instance.new("Frame")
            header.AnchorPoint = Vector2.new(0.5, 0)
            header.Name = "Header"
            header.Position = UDim2.new(0.5, 0, 0, 0)
            header.BorderColor3 = Color3.fromRGB(0, 0, 0)
            header.Size = UDim2.new(0, 260, 0, 32)
            header.BorderSizePixel = 0
            header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            header.Parent = sectionFrame
            
            -- Create section name
            local sectionName = Instance.new("TextLabel")
            sectionName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            sectionName.TextColor3 = Color3.fromRGB(125, 69, 220)
            sectionName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            sectionName.Text = sectionText
            sectionName.Name = "Section_Name"
            sectionName.TextStrokeTransparency = 0.8500000238418579
            sectionName.AnchorPoint = Vector2.new(0.5, 0.5)
            sectionName.Size = UDim2.new(0, 1, 0, 1)
            sectionName.BackgroundTransparency = 1
            sectionName.Position = UDim2.new(0.5, 0, 0.5, 0)
            sectionName.BorderSizePixel = 0
            sectionName.AutomaticSize = Enum.AutomaticSize.XY
            sectionName.TextSize = 14
            sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.Parent = header
            
            -- Create inline accent
            local inline = Instance.new("Frame")
            inline.AnchorPoint = Vector2.new(0, 1)
            inline.Name = "Inline"
            inline.Position = UDim2.new(0, 0, 1, 0)
            inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
            inline.Size = UDim2.new(1, 1, 0, 4)
            inline.BorderSizePixel = 0
            inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            inline.Parent = header
            
            local uiGradient = Instance.new("UIGradient")
            uiGradient.Rotation = 90
            uiGradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
                NumberSequenceKeypoint.new(1, 0)
            }
            uiGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
            }
            uiGradient.Parent = inline
            
            -- Create holder for components
            local holder = Instance.new("Frame")
            holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
            holder.AnchorPoint = Vector2.new(0.5, 0)
            holder.Name = "Holder"
            holder.BackgroundTransparency = 1
            holder.Position = UDim2.new(0.5, 0, 1, 0)
            holder.Size = UDim2.new(0, 1, 0, 1)
            holder.BorderSizePixel = 0
            holder.AutomaticSize = Enum.AutomaticSize.XY
            holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            holder.Parent = header
            
            local uiListLayout = Instance.new("UIListLayout")
            uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            uiListLayout.Parent = holder
            
            local uiPadding = Instance.new("UIPadding")
            uiPadding.PaddingBottom = UDim.new(0, 35)
            uiPadding.PaddingTop = UDim.new(0, 4)
            uiPadding.Parent = holder
            
            -- Add stroke to section
            local uiStroke = Instance.new("UIStroke")
            uiStroke.Color = Color3.fromRGB(35, 35, 35)
            uiStroke.Parent = sectionFrame
            
            -- Store section reference
            Sections[position] = Sections[position] or {}
            table.insert(Sections[position], section)
            
            -- Section methods (placeholder functions for now)
            function section:CreateToggle(options)
                print("Toggle created:", options.ToggleText)
                return {}
            end
            
            function section:CreateSlider(options)
                print("Slider created:", options.SliderText)
                return {}
            end
            
            function section:CreateLabel(options)
                print("Label created:", options.LabelText)
                return {}
            end
            
            function section:CreateTextInput(options)
                print("TextInput created:", options.TextInputText)
                return {}
            end
            
            function section:CreateDropdown(options)
                print("Dropdown created:", options.DropdownText)
                return {}
            end
            
            function section:CreateToggleWithKeybind(options)
                print("ToggleWithKeybind created:", options.ToggleText)
                return {}
            end
            
            function section:AddColorToggle(options)
                print("ColorToggle created:", options.Text)
                return {}
            end
            
            function section:CreateKeybind(options)
                print("Keybind created:", options.KeybindText)
                return {}
            end
            
            function section:CreateColorpicker(options)
                print("Colorpicker created:", options.ColorpickerText)
                return {}
            end
            
            function section:CreateButton(options)
                print("Button created:", options.ButtonText)
                return {}
            end
            
            function section:CreateConfig(options)
                print("Config created:", options.Text)
                return {}
            end
            
            return section
        end
        
        return tab
    end
    
    -- Window-level section creation (for backwards compatibility)
    function window:CreateSection(sectionOptions)
        if CurrentTab then
            return CurrentTab:CreateSection(sectionOptions)
        else
            print("Warning: No active tab for section creation")
            return {}
        end
    end
    
    CurrentWindow = window
    Windows[#Windows + 1] = window
    
    return window
end

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

-- Example tabs removed - tabs will be created dynamically

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

-- Example sections and components removed - they will be created dynamically

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

local UIGradient2 = Instance.new("UIGradient")
UIGradient2.Rotation = -90
UIGradient2.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.394, 1),
	NumberSequenceKeypoint.new(0.596, 0.6812499761581421),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient2.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 65, 204)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(117, 65, 204))
}
UIGradient2.Parent = Inline

-- UI Toggle and dragging functionality
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local isVisible = true

local fadeInInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local fadeOutInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

local function fadeIn()
    MainFrame.Visible = true
    MainFrame.BackgroundTransparency = 1
    local fadeInTween = TweenService:Create(MainFrame, fadeInInfo, {BackgroundTransparency = 0})
    fadeInTween:Play()
end

local function fadeOut()
    local fadeOutTween = TweenService:Create(MainFrame, fadeOutInfo, {BackgroundTransparency = 1})
    fadeOutTween:Play()
    fadeOutTween.Completed:Connect(function()
        MainFrame.Visible = false
    end)
end

local function toggleUI()
    isVisible = not isVisible
    if isVisible then
        fadeIn()
    else
        fadeOut()
    end
end

-- Drag functionality
local DragHeader = MainFrame:FindFirstChild("Header")
if DragHeader then
	local dragging = false
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end

	DragHeader.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	DragHeader.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

return libary

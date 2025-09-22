-- CharlieWare UI Library
local Library = {}
Library.__index = Library

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Library Functions
function Library:CreateWindow(windowName)
    local Window = {}
    Window.__index = Window
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    -- Create ScreenGui for the UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CharliewareUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

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
    Libary_Name.Text = (windowName or 'CharlieWare') .. '<font color="#7D45DC">.rbx</font>'
    Libary_Name.Name = "Libary_Name"
    Libary_Name.BackgroundTransparency = 1
    Libary_Name.Position = UDim2.new(0, 12, 0.5, 0)
    Libary_Name.TextWrapped = true
    Libary_Name.BorderSizePixel = 0
    Libary_Name.AutomaticSize = Enum.AutomaticSize.XY
    Libary_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Libary_Name.Parent = Header

    local TabContainer = Instance.new("Frame")
    TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabContainer.AnchorPoint = Vector2.new(1, 0.5)
    TabContainer.BackgroundTransparency = 12
    TabContainer.Position = UDim2.new(1, 0, 0.5, 0)
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 425, 0, 40)
    TabContainer.BorderSizePixel = 0
    TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabContainer.Parent = Header

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    TabListLayout.Padding = UDim.new(0, 18)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Parent = TabContainer

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.Parent = TabContainer

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

    local PageContainer = Instance.new("ScrollingFrame")
    PageContainer.ScrollBarImageColor3 = Color3.fromRGB(125, 69, 220)
    PageContainer.MidImage = "rbxassetid://78742712038042"
    PageContainer.Active = true
    PageContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PageContainer.Name = "PageContainer"
    PageContainer.Size = UDim2.new(0, 563, 0, 334)
    PageContainer.TopImage = ""
    PageContainer.BackgroundTransparency = 1
    PageContainer.BottomImage = ""
    PageContainer.BorderSizePixel = 0
    PageContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PageContainer.Parent = Page

    local PageListLayout = Instance.new("UIListLayout")
    PageListLayout.Wraps = true
    PageListLayout.Padding = UDim.new(0, 16)
    PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageListLayout.FillDirection = Enum.FillDirection.Horizontal
    PageListLayout.Parent = PageContainer

    local PagePadding = Instance.new("UIPadding")
    PagePadding.PaddingTop = UDim.new(0, 12)
    PagePadding.PaddingLeft = UDim.new(0, 12)
    PagePadding.Parent = PageContainer
    
    -- Store references for the window
    Window.ScreenGui = ScreenGui
    Window.MainFrame = MainFrame
    Window.TabContainer = TabContainer
    Window.PageContainer = PageContainer
    Window.BG_BLUR = BG_BLUR

    -- CreateTab function
    function Window:CreateTab(options)
        local Tab = {}
        Tab.__index = Tab
        Tab.Sections = {}
        Tab.Name = options.TabText or "Tab"
        Tab.Window = Window
        Tab.Visible = false
        
        -- Create tab button
        local TabFrame = Instance.new("Frame")
        TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabFrame.Name = "Tab"
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size = UDim2.new(0, 47, 0, 40)
        TabFrame.BorderSizePixel = 0
        TabFrame.AutomaticSize = Enum.AutomaticSize.X
        TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabFrame.Parent = TabContainer
        
        local TabInline = Instance.new("Frame")
        TabInline.AnchorPoint = Vector2.new(0, 1)
        TabInline.Name = "Inline"
        TabInline.Position = UDim2.new(0, 0, 1, 0)
        TabInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabInline.Size = UDim2.new(1, 1, 0, 4)
        TabInline.BorderSizePixel = 0
        TabInline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabInline.Parent = TabFrame
        TabInline.Visible = false
        
        local TabGradient = Instance.new("UIGradient")
        TabGradient.Rotation = 90
        TabGradient.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
            NumberSequenceKeypoint.new(1, 0)
        }
        TabGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
        }
        TabGradient.Parent = TabInline
        
        local TabLabel = Instance.new("TextLabel")
        TabLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        TabLabel.TextStrokeTransparency = 0.8999999761581421
        TabLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TabLabel.TextSize = 15
        TabLabel.Size = UDim2.new(0, 1, 0, 1)
        TabLabel.RichText = true
        TabLabel.TextColor3 = Color3.fromRGB(169, 169, 169)
        TabLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabLabel.Text = Tab.Name
        TabLabel.Name = "Tab_Name"
        TabLabel.BackgroundTransparency = 1
        TabLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        TabLabel.TextWrapped = true
        TabLabel.BorderSizePixel = 0
        TabLabel.AutomaticSize = Enum.AutomaticSize.XY
        TabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabLabel.Parent = TabFrame
        
        -- Create tab content frame
        local TabContent = Instance.new("Frame")
        TabContent.Name = Tab.Name .. "_Content"
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BorderSizePixel = 0
        TabContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.Parent = PageContainer
        TabContent.Visible = false
        
        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.Wraps = true
        TabContentLayout.Padding = UDim.new(0, 16)
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.FillDirection = Enum.FillDirection.Horizontal
        TabContentLayout.Parent = TabContent
        
        -- Tab selection logic
        local function selectTab()
            -- Hide all other tabs
            for _, existingTab in pairs(Window.Tabs) do
                existingTab.Frame:FindFirstChild("Inline").Visible = false
                existingTab.Frame:FindFirstChild("Tab_Name").TextColor3 = Color3.fromRGB(169, 169, 169)
                existingTab.Content.Visible = false
            end
            
            -- Show this tab
            TabInline.Visible = true
            TabLabel.TextColor3 = Color3.fromRGB(125, 69, 220)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        -- Click detection
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 1, 0)
        TabButton.BackgroundTransparency = 1
        TabButton.Text = ""
        TabButton.Parent = TabFrame
        TabButton.MouseButton1Click:Connect(selectTab)
        
        Tab.Frame = TabFrame
        Tab.Content = TabContent
        Tab.SelectTab = selectTab
        
        -- CreateSection function for tabs
        function Tab:CreateSection(options)
            local Section = {}
            Section.__index = Section
            Section.Name = options.SectionText or "Section"
            Section.Position = options.position or "left"
            Section.Components = {}
            
            -- Create section frame
            local SectionFrame = Instance.new("Frame")
            SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionFrame.Name = "Section_" .. Section.Position
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Size = UDim2.new(0, 260, 0, 60)
            SectionFrame.BorderSizePixel = 0
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            SectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionFrame.Parent = TabContent
            
            local SectionHeader = Instance.new("Frame")
            SectionHeader.AnchorPoint = Vector2.new(0.5, 0)
            SectionHeader.Name = "Header"
            SectionHeader.Position = UDim2.new(0.5, 0, 0, 0)
            SectionHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionHeader.Size = UDim2.new(0, 260, 0, 32)
            SectionHeader.BorderSizePixel = 0
            SectionHeader.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            SectionHeader.Parent = SectionFrame
            
            local SectionInline = Instance.new("Frame")
            SectionInline.AnchorPoint = Vector2.new(0, 1)
            SectionInline.Name = "Inline"
            SectionInline.Position = UDim2.new(0, 0, 1, 0)
            SectionInline.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionInline.Size = UDim2.new(1, 1, 0, 4)
            SectionInline.BorderSizePixel = 0
            SectionInline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionInline.Parent = SectionHeader
            
            local SectionGradient = Instance.new("UIGradient")
            SectionGradient.Rotation = 90
            SectionGradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
                NumberSequenceKeypoint.new(1, 0)
            }
            SectionGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
            }
            SectionGradient.Parent = SectionInline
            
            local SectionHolder = Instance.new("Frame")
            SectionHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionHolder.AnchorPoint = Vector2.new(0.5, 0)
            SectionHolder.Name = "Holder"
            SectionHolder.BackgroundTransparency = 1
            SectionHolder.Position = UDim2.new(0.5004807710647583, 0, 1, 0)
            SectionHolder.Size = UDim2.new(0, 1, 0, 1)
            SectionHolder.BorderSizePixel = 0
            SectionHolder.AutomaticSize = Enum.AutomaticSize.XY
            SectionHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionHolder.Parent = SectionHeader
            
            local SectionListLayout = Instance.new("UIListLayout")
            SectionListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionListLayout.Parent = SectionHolder
            
            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.PaddingBottom = UDim.new(0, 35)
            SectionPadding.PaddingTop = UDim.new(0, 4)
            SectionPadding.Parent = SectionHolder
            
            local SectionName = Instance.new("TextLabel")
            SectionName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            SectionName.TextColor3 = Color3.fromRGB(125, 69, 220)
            SectionName.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionName.Text = Section.Name
            SectionName.Name = "Section_Name"
            SectionName.TextStrokeTransparency = 0.8500000238418579
            SectionName.AnchorPoint = Vector2.new(0.5, 0.5)
            SectionName.Size = UDim2.new(0, 1, 0, 1)
            SectionName.BackgroundTransparency = 1
            SectionName.Position = UDim2.new(0.5, 0, 0.5, 0)
            SectionName.BorderSizePixel = 0
            SectionName.AutomaticSize = Enum.AutomaticSize.XY
            SectionName.TextSize = 14
            SectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionName.Parent = SectionHeader
            
            local SectionStroke = Instance.new("UIStroke")
            SectionStroke.Color = Color3.fromRGB(35, 35, 35)
            SectionStroke.Parent = SectionFrame
            
            Section.Frame = SectionFrame
            Section.Holder = SectionHolder
            
            -- Add placeholder component creation methods
            function Section:CreateToggle(options) return {Enabled = false} end
            function Section:CreateSlider(options) return {Value = options.Value or 0} end
            function Section:CreateDropdown(options) return {Selected = ""} end
            function Section:CreateButton(options) return {} end
            function Section:CreateKeybind(options) return {Key = ""} end
            function Section:CreateColorpicker(options) return {Color = Color3.new(1,1,1)} end
            function Section:CreateTextInput(options) return {Text = ""} end
            function Section:CreateLabel(options) return {} end
            function Section:CreateConfig(options) return {} end
            function Section:CreateToggleWithKeybind(options) return {Enabled = false, Key = ""} end
            function Section:AddColorToggle(options) return {Enabled = false, Color = Color3.new(1,1,1)} end
            
            table.insert(Tab.Sections, Section)
            return Section
        end
        
        -- Store tab and select first one
        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then
            selectTab()
        end
        
        return Tab
    end
    
    -- Window CreateSection method (for backwards compatibility)
    function Window:CreateSection(options)
        if Window.CurrentTab then
            return Window.CurrentTab:CreateSection(options)
        else
            error("No active tab. Create a tab first.")
        end
    end
    
    -- Add footer and toggle functionality
    addFooterAndToggle(Window)
    
    print("CHARLIEWARE UI Loaded! Press Insert to toggle.")
    
    return Window
end

-- Hide all example sections below this point
--[[
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

--]]

-- Add footer and toggle functionality at the end
local function addFooterAndToggle(Window)
    local MainFrame = Window.MainFrame
    local BG_BLUR = Window.BG_BLUR
    
    -- Create footer
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
    footer_left_label.Text = "CharlieWare"
    footer_left_label.Name = "footer_left_label"
    footer_left_label.BackgroundTransparency = 1
    footer_left_label.Position = UDim2.new(0, 12, 0.5, 0)
    footer_left_label.TextWrapped = true
    footer_left_label.BorderSizePixel = 0
    footer_left_label.AutomaticSize = Enum.AutomaticSize.XY
    footer_left_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    footer_left_label.Parent = Footer
    
    local FooterContainer = Instance.new("Frame")
    FooterContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    FooterContainer.AnchorPoint = Vector2.new(1, 0.5)
    FooterContainer.Name = "Container"
    FooterContainer.BackgroundTransparency = 12
    FooterContainer.Position = UDim2.new(1, 0, 0.5000065565109253, 0)
    FooterContainer.Size = UDim2.new(0, 105, 0, 28)
    FooterContainer.BorderSizePixel = 0
    FooterContainer.AutomaticSize = Enum.AutomaticSize.XY
    FooterContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FooterContainer.Parent = Footer
    
    local FooterListLayout = Instance.new("UIListLayout")
    FooterListLayout.FillDirection = Enum.FillDirection.Horizontal
    FooterListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    FooterListLayout.Padding = UDim.new(0, 12)
    FooterListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    FooterListLayout.Parent = FooterContainer
    
    local FooterPadding = Instance.new("UIPadding")
    FooterPadding.PaddingTop = UDim.new(0, 6)
    FooterPadding.PaddingRight = UDim.new(0, 12)
    FooterPadding.Parent = FooterContainer
    
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
    footer_text.Parent = FooterContainer
    
    -- Create bottom text
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
    
    local BottomListLayout = Instance.new("UIListLayout")
    BottomListLayout.FillDirection = Enum.FillDirection.Horizontal
    BottomListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    BottomListLayout.Padding = UDim.new(0, 12)
    BottomListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    BottomListLayout.Parent = Libary_Bottom_Text
    
    local BottomPadding = Instance.new("UIPadding")
    BottomPadding.PaddingTop = UDim.new(0, 6)
    BottomPadding.PaddingRight = UDim.new(0, 12)
    BottomPadding.Parent = Libary_Bottom_Text
    
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
    
    -- Toggle functionality
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
    
    -- Store references
    Window.Footer = Footer
    Window.BottomText = Libary_Bottom_Text
    Window.ToggleUI = toggleUI
end

-- Return the library
return Library


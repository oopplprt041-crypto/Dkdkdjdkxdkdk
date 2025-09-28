task.wait(1)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- ฟังก์ชัน Rainbow Gradient
local function smoothRainbow(target)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
        ColorSequenceKeypoint.new(1/6, Color3.fromRGB(255,127,0)),
        ColorSequenceKeypoint.new(2/6, Color3.fromRGB(255,255,0)),
        ColorSequenceKeypoint.new(3/6, Color3.fromRGB(0,255,0)),
        ColorSequenceKeypoint.new(4/6, Color3.fromRGB(0,0,255)),
        ColorSequenceKeypoint.new(5/6, Color3.fromRGB(75,0,130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(148,0,211))
    }
    g.Rotation = 0
    g.Parent = target

    task.spawn(function()
        while task.wait(0.02) do
            g.Rotation = (g.Rotation + 1) % 360
        end
    end)
end

-- ฟังก์ชันทำให้ GUI ค่อยๆ หายไป
local function fadeOutAndDestroy(frame)
    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(frame, tweenInfo, {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 50, 0, 50)
    })
    tween:Play()
    tween.Completed:Wait()
    frame:Destroy()
end

-- ✅ กัน GUI ซ้ำ
if CoreGui:FindFirstChild("BossGui") then
    local BigWarn = Instance.new("TextLabel")
    BigWarn.Size = UDim2.new(1, 0, 1, 0)
    BigWarn.BackgroundTransparency = 0
    BigWarn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BigWarn.Text = "ไอควายมันอันเก่าก็ยังอยู่แล้วเรียกใสเลย💀🦴"
    BigWarn.Font = Enum.Font.GothamBold
    BigWarn.TextSize = 50
    BigWarn.TextColor3 = Color3.fromRGB(255, 255, 255)
    BigWarn.TextWrapped = true
    BigWarn.Parent = CoreGui
    smoothRainbow(BigWarn)

    task.delay(10, function()
        fadeOutAndDestroy(BigWarn)
    end)

    return
end

-- Gui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BossGui"
ScreenGui.Parent = CoreGui

---------------------------------------------------
-- 🔹 Loading Screen (วุ้บขึ้น-วุ้บลง+FadeOut)
---------------------------------------------------
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 300, 0, 100)
LoadingFrame.Position = UDim2.new(0.35, 0, 1.2, 0) -- เริ่มล่างจอ
LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LoadingFrame.Parent = ScreenGui
LoadingFrame.Visible = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = LoadingFrame

-- ✅ ข้อความชื่อผู้ใช้
local HelloText = Instance.new("TextLabel")
HelloText.Size = UDim2.new(0.95, 0, 0.4, 0)
HelloText.Position = UDim2.new(0.025, 0, 0, 5)
HelloText.BackgroundTransparency = 1
HelloText.Text = "ไอเปรตลิฟผอมกระดูกผี💀🦴 "..player.Name
HelloText.Font = Enum.Font.GothamBold
HelloText.TextSize = 22
HelloText.TextColor3 = Color3.fromRGB(255, 255, 255)
HelloText.TextWrapped = true
HelloText.TextScaled = true
HelloText.TextXAlignment = Enum.TextXAlignment.Center
HelloText.TextYAlignment = Enum.TextYAlignment.Center
HelloText.Parent = LoadingFrame
smoothRainbow(HelloText)

-- ✅ Progress Bar
local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0.9, 0, 0.25, 0)
BarBG.Position = UDim2.new(0.05, 0, 0.65, 0)
BarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BarBG.Parent = LoadingFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 10)
BarCorner.Parent = BarBG

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
BarFill.Parent = BarBG

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(0, 10)
BarFillCorner.Parent = BarFill

-- 🔹 Tween: วุ้บขึ้น
TweenService:Create(LoadingFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.35, 0, 0.4, 0)
}):Play()

-- 🔹 Tween Bar โหลด
local tween = TweenService:Create(BarFill, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(1,0,1,0)})
tween:Play()
tween.Completed:Wait()

-- 🔹 Tween: วุ้บลง + FadeOut + Destroy
local downTween = TweenService:Create(LoadingFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
    Position = UDim2.new(0.35, 0, 1.2, 0),
    BackgroundTransparency = 1
})
downTween:Play()

for _, v in pairs(LoadingFrame:GetDescendants()) do
    if v:IsA("TextLabel") or v:IsA("Frame") then
        local props = {}
        if v:IsA("TextLabel") then
            props.TextTransparency = 1
        end
        if v:IsA("Frame") then
            props.BackgroundTransparency = 1
        end
        TweenService:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Quad), props):Play()
    end
end

downTween.Completed:Wait()
LoadingFrame:Destroy()

---------------------------------------------------
-- 🔹 GUI หลัก (MainFrame)
---------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundTransparency = 0
MainFrame.Active = true
MainFrame.Draggable = false
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
smoothRainbow(MainFrame)

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0,15)
UICorner2.Parent = MainFrame

-- Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0,0,0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10,10,118,118)
Shadow.Size = UDim2.new(1,30,1,30)
Shadow.Position = UDim2.new(0,-15,0,-15)
Shadow.BackgroundTransparency = 1
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1,0,0,30)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BackgroundColor3 = Color3.fromRGB(0,0,0)
TitleBar.Text = "เมนูวานลิต"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 18
TitleBar.TextColor3 = Color3.fromRGB(255,255,255)
TitleBar.Parent = MainFrame
smoothRainbow(TitleBar)

local ButtonContainer = Instance.new("ScrollingFrame")
ButtonContainer.Size = UDim2.new(1, -10, 1, -40)
ButtonContainer.Position = UDim2.new(0, 5, 0, 35)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.ScrollBarThickness = 6
ButtonContainer.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
ButtonContainer.ScrollBarImageTransparency = 0.3
ButtonContainer.Parent = MainFrame
ButtonContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonContainer
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- เอฟเฟกต์ปุ่ม
local function animateClick(btn)
    btn.MouseButton1Click:Connect(function()
        local grow = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = btn.Size + UDim2.new(0,5,0,5)
        })
        local shrink = TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = btn.Size
        })
        grow:Play()
        grow.Completed:Wait()
        shrink:Play()
    end)
end

-- ฟังก์ชันสร้างปุ่ม
local function createButton(name, callback, index)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BackgroundTransparency = 1
    btn.TextTransparency = 1
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = ButtonContainer

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40,40,40)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20,20,20)}):Play()
    end)

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Parent = btn
    smoothRainbow(stroke)

    smoothRainbow(btn)
    animateClick(btn)

    task.spawn(function()
        task.wait(0.2 * index)
        TweenService:Create(btn, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.2,
            TextTransparency = 0
        }):Play()
    end)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- รายชื่อปุ่ม (เรียงใหม่)
local buttons = {
    {"👉👌👉👌👉👌👉👌👉👌", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/Dufufdjdj.lua/refs/heads/main/Djrjrkrkr.lua"))()
    end},
    {"👉👌 ESPวานลิต", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/Fifififdjdidjsjwjdj/refs/heads/main/Djdkdkekrkrfkdk.lua"))()
    end},
    {"👉👌 ทะลุวานลิต", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/no-clip/refs/heads/main/no-clip.lua"))()
    end},
    {"👉👌 วาปไปหาวานลิต", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/TOOUUUU/refs/heads/main/TOOOIIIIII.lua"))()
    end},
    {"👉👌 โปรบินโง่ๆ", function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-nameless-admin-15646"))()
    end},
    {"👉👌 วิ่งไวหีลิต", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/SERRR/refs/heads/main/speerorkrdkdk.lua"))()
    end},
    {"👉👌 วานลิตติดกำแผง", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/Yuygyf/refs/heads/main/Rtfgd.lua"))()
    end},
    {"👉👌 ฟรีผัวลิตส่วนตัว", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/Dvisivivscis-/refs/heads/main/Djdjdjd.lua"))()
    end},
    {"👉👌 วานลิตโคตรแจง", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/H-he-eessdddd/refs/heads/main/Reddedf.lua"))()
    end}
}

for i, data in ipairs(buttons) do
    createButton(data[1], data[2], i)
end

---------------------------------------------------
-- 🔹 Animation Show/Hide MainFrame + Blur (กันกดรัว)
---------------------------------------------------
local isAnimating = false

local function showWithAnimation(frame)
    isAnimating = true
    local Blur = Instance.new("BlurEffect", game.Lighting)
    Blur.Size = 0
    TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = 15}):Play()

    frame.Visible = true
    local tween = TweenService:Create(frame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 260, 0, 320)
    })
    tween:Play()
    tween.Completed:Wait()
    isAnimating = false
end

local function hideWithAnimation(frame)
    isAnimating = true
    local tween = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 50, 0, 60)
    })
    tween:Play()
    tween.Completed:Wait()
    frame.Visible = false

    local blur = game.Lighting:FindFirstChildOfClass("BlurEffect")
    if blur then
        TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = 0}):Play()
        task.delay(0.5, function()
            blur:Destroy()
        end)
    end
    isAnimating = false
end

local function toggleGui(frame, state)
    if isAnimating then return end
    if state then
        showWithAnimation(frame)
    else
        hideWithAnimation(frame)
    end
end

---------------------------------------------------
-- 🔹 Smooth Drag
---------------------------------------------------
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
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

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

---------------------------------------------------
-- 🔹 Toggle Button
---------------------------------------------------
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Position = UDim2.new(0.35, 0, 0.25, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.Text = " เปิดควย"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Parent = ScreenGui
ToggleButton.Active = true
ToggleButton.Draggable = true
smoothRainbow(ToggleButton)

local isOpen = true
ToggleButton.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isOpen = not isOpen
    toggleGui(MainFrame, isOpen)
    ToggleButton.Text = isOpen and " ปิดควย" or " เปิดควย"
end)

-- ✅ โชว์ MainFrame แบบเต็มตั้งแต่แรก
MainFrame.Visible = true
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.BackgroundTransparency = 0

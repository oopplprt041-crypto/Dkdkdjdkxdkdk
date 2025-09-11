-- Gui หลัก
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton")

-- ตั้งค่า ScreenGui
ScreenGui.Parent = game:GetService("CoreGui")

-- MainFrame
MainFrame.Size = UDim2.new(0, 240, 0, 260)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundTransparency = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- ใส่มุมโค้ง
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,15)
UICorner.Parent = MainFrame

-- ใส่เส้นขอบ
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255,255,255)
UIStroke.Transparency = 0.2
UIStroke.Parent = MainFrame

-- ไล่เฉดสีรุ้ง RGB
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),     -- แดง
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255,127,0)),-- ส้ม
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255,255,0)),-- เหลือง
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,0)),   -- เขียว
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0,0,255)),  -- น้ำเงิน
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75,0,130)), -- คราม
    ColorSequenceKeypoint.new(1, Color3.fromRGB(148,0,211))    -- ม่วง
}
UIGradient.Rotation = 0
UIGradient.Parent = MainFrame

-- ทำให้เฉดสีเคลื่อนไหวเป็น RGB loop
task.spawn(function()
    while task.wait(0.05) do
        UIGradient.Rotation = (UIGradient.Rotation + 2) % 360
    end
end)

-- Title Bar
local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1,0,0,30)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BackgroundColor3 = Color3.fromRGB(0,0,0)
TitleBar.Text = "เมนูวานลิต"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 18
TitleBar.TextColor3 = Color3.fromRGB(255,255,255)
TitleBar.Parent = MainFrame
TitleBar.ZIndex = 2

-- UIListLayout (ย้ายลงมาให้ไม่ชน Title Bar)
UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ฟังก์ชันสร้างปุ่ม (พร้อมตัวอักษรสีรุ้ง)
local function createButton(name, callback, gradient)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0,0,0,35) -- เว้นจาก TitleBar
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BackgroundTransparency = 0.3
    btn.TextTransparency = 1 -- ซ่อนข้อความของปุ่ม
    btn.Parent = MainFrame

    -- ทำ TextLabel ซ้อนบนปุ่ม
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = name
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 16
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.Parent = btn

    -- ใช้ Gradient เดียวกับ MainFrame
    local txtGradient = Instance.new("UIGradient")
    txtGradient.Color = gradient.Color
    txtGradient.Rotation = gradient.Rotation
    txtGradient.Parent = txt

    -- อัพเดท Gradient Rotation พร้อมกัน
    task.spawn(function()
        while task.wait(0.05) do
            txtGradient.Rotation = gradient.Rotation
        end
    end)

    -- เอฟเฟกต์ hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.1
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.3
    end)

    -- กดปุ่ม
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ปุ่มต่างๆ
createButton("👉👌 ESPวานลิต", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/Fifififdjdidjsjwjdj/refs/heads/main/Djdkdkekrkrfkdk.lua"))()
end, UIGradient)

createButton("👉👌 ทะลุวานลิต", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/no-clip/refs/heads/main/no-clip.lua"))()
end, UIGradient)

createButton("👉👌 วาปไปหาวานลิต", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/oopplprt041-crypto/TOOUUUU/refs/heads/main/TOOOIIIIII.lua"))()
end, UIGradient)

createButton("👉👌โปรบินโง่ๆ", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-nameless-admin-15646"))()
end, UIGradient)

-- ปุ่มพับ/กาง GUI (อยู่นอก MainFrame)
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0.35, 0, 0.25, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.Text = " เปิดควย"
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Parent = ScreenGui
ToggleButton.Active = true
ToggleButton.Draggable = true

local isCollapsed = false
ToggleButton.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    MainFrame.Visible = not isCollapsed
    ToggleButton.Text = isCollapsed and "เปิดควย" or "ปิดควย"
end)

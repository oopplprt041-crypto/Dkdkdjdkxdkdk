--// Full Screen Rainbow GUI by Boss
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RainbowFullScreen"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Frame เต็มจอ
local RainbowFrame = Instance.new("Frame")
RainbowFrame.Size = UDim2.new(1, 0, 1, 0)
RainbowFrame.Position = UDim2.new(0, 0, 0, 0)
RainbowFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RainbowFrame.Parent = ScreenGui

-- UIGradient สำหรับทำสีรุ้ง
local Gradient = Instance.new("UIGradient")
Gradient.Rotation = 0
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),   -- แดง
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 127, 0)), -- ส้ม
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)), -- เหลือง
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),   -- เขียว
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),   -- น้ำเงิน
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 0, 255))    -- ม่วง
}
Gradient.Parent = RainbowFrame

-- ทำให้ Gradient หมุน RGB ไปเรื่อยๆ
task.spawn(function()
    while task.wait(0.05) do
        Gradient.Rotation = (Gradient.Rotation + 2) % 360
    end
end)

-- TextLabel ตรงกลางจอ
local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.2, 0)
TextLabel.Position = UDim2.new(0, 0, 0.4, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "กูไม่ให้มึงใช้แล้ว ไอลิฟผอมกระดูกผี💀🦴"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextScaled = true
TextLabel.Parent = RainbowFrame

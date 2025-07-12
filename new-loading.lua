local player = game.Players.LocalPlayer

-- Buat ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "RollbackLoadingUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999
gui.Parent = player:WaitForChild("PlayerGui")

-- Bar loading utama (diperlebar dan dipindahkan ke bawah)
local bar = Instance.new("Frame", gui)
bar.Size = UDim2.new(0.5, 0, 0.075, 0)  -- Lebar sedikit, tinggi sedikit
bar.Position = UDim2.new(0.25, 0, 0.75, 0)  -- Lebih ke bawah
bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bar.BorderSizePixel = 0
bar.ZIndex = 20
local corner = Instance.new("UICorner", bar)
corner.CornerRadius = UDim.new(0, 30)

-- Garis scan biru rollback
local scan = Instance.new("Frame", bar)
scan.Size = UDim2.new(0.2, 0, 1, 0)
scan.Position = UDim2.new(0, 0, 0, 0)
scan.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
scan.BorderSizePixel = 0
scan.ZIndex = 21
local scanCorner = Instance.new("UICorner", scan)
scanCorner.CornerRadius = UDim.new(0, 30)

-- Glow gradient
local gradient = Instance.new("UIGradient", scan)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
}
gradient.Rotation = 0

-- Text only version (no background)
local loadingText = Instance.new("TextLabel", gui)
loadingText.Size = UDim2.new(0.10, 0, 0.05, 0)
loadingText.Position = UDim2.new(0.40, 0, 0.70, 0)
loadingText.Text = "Looking For Old Server"
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 18
loadingText.TextColor3 = Color3.fromRGB(220, 220, 220)
loadingText.BackgroundTransparency = 1  -- Fully transparent background
loadingText.TextXAlignment = Enum.TextXAlignment.Left
loadingText.ZIndex = 20

-- Animasi titik-titik di akhir teks
local dots = {".", "..", "...", "...."}
local dotIndex = 1
task.spawn(function()
    while true do
        loadingText.Text = "Looking For Old Server" .. dots[dotIndex]
        dotIndex = dotIndex % #dots + 1
        wait(0.5)
    end
end)

-- Jendela info di pojok kanan atas (lebih besar dan lebih ke pojok)
local infoBox = Instance.new("Frame", gui)
infoBox.Size = UDim2.new(0.3, 0, 0.30, 0)  -- Lebih besar
infoBox.Position = UDim2.new(0.70, -10, -0.07, 0)  -- Lebih ke pojok
infoBox.BackgroundColor3 = Color3.new(0, 0, 0)
infoBox.BackgroundTransparency = 0.3
infoBox.BorderSizePixel = 0
infoBox.ZIndex = 30
local infoCorner = Instance.new("UICorner", infoBox)
infoCorner.CornerRadius = UDim.new(0, 8)

-- Title bar untuk jendela info
local titleBar = Instance.new("Frame", infoBox)
titleBar.Size = UDim2.new(1, 0, 0.20, 0)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 31
local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Name = "TopCorner"

-- Hanya corner atas yang dibulatkan
local bottomCover = Instance.new("Frame", titleBar)
bottomCover.Size = UDim2.new(1, 0, 0.5, 0)
bottomCover.Position = UDim2.new(0, 0, 0.5, 0)
bottomCover.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
bottomCover.BorderSizePixel = 0
bottomCover.ZIndex = 31

-- Judul jendela
local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.Text = "SCRIPT INFO"
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 25
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.BackgroundTransparency = 1
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 32

-- Konten jendela info
local infoContent = Instance.new("ScrollingFrame", infoBox)
infoContent.Size = UDim2.new(1, -10, 0.85, 0)
infoContent.Position = UDim2.new(0, 5, 0.23, 0)
infoContent.BackgroundTransparency = 1
infoContent.BorderSizePixel = 0
infoContent.ScrollBarThickness = 4
infoContent.ZIndex = 31
infoContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
infoContent.CanvasSize = UDim2.new(0, 0, 0, 0)

local infoLayout = Instance.new("UIListLayout", infoContent)
infoLayout.Padding = UDim.new(0, 5)

-- Fungsi untuk menambahkan info ke jendela
function addInfo(text)
    local infoItem = Instance.new("TextLabel", infoContent)
    infoItem.Size = UDim2.new(1, 0, 0, 32)  -- Sedikit lebih rapat
    infoItem.Position = UDim2.new(0, 5, 0, 0)  -- Margin kiri kecil
    infoItem.Text = "" .. text  -- Bullet point dengan spasi normal
    infoItem.Font = Enum.Font.GothamBold  -- Pakai font bold
    infoItem.TextSize = 16  -- Ukuran standar
    infoItem.TextColor3 = Color3.fromRGB(230, 230, 230)  -- Warna teks terang
    infoItem.BackgroundTransparency = 1
    infoItem.TextXAlignment = Enum.TextXAlignment.Left
    infoItem.ZIndex = 32
    infoItem.AutomaticSize = Enum.AutomaticSize.Y
    infoItem.TextWrapped = true
    
    -- Tambahkan efek stroke untuk teks lebih tebal
    local textStroke = Instance.new("UIStroke", infoItem)
    textStroke.Color = Color3.fromRGB(50, 50, 50)
    textStroke.Thickness = 1.2
    textStroke.Transparency = 0.5
end

addInfo("Wait about 15 to 20 minutes. Don't be surprised if you see some background stuff - that's just the system working to teleport you to the right spot. It might kick random players if the server gets full")

-- Animasikan rollback scan kiri-kanan
task.spawn(function()
    local toRight = true
    while true do
        if toRight then
            scan:TweenPosition(UDim2.new(0.8, 0, 0, 0), "Out", "Sine", 1.5, true)
        else
            scan:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Sine", 1.5, true)
        end
        toRight = not toRight
        wait(1.5)
    end
end)

-- Animasi tambahan: efek cahaya pada scan bar
task.spawn(function()
    while true do
        -- Animasi opacity gradient
        for i = 0, 1, 0.05 do
            gradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.5 - i/2),
                NumberSequenceKeypoint.new(0.5, 0.2),
                NumberSequenceKeypoint.new(1, 0.5 + i/2)
            }
            wait(0.05)
        end
        
        for i = 0, 1, 0.05 do
            gradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.5 + i/2),
                NumberSequenceKeypoint.new(0.5, 0.2),
                NumberSequenceKeypoint.new(1, 0.5 - i/2)
            }
            wait(0.05)
        end
    end
end)
-- Pedro Scripts - Menu completo com LED e botões rainbow
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local LocalPlayer=Players.LocalPlayer
local PlayerGui=LocalPlayer:FindFirstChild("PlayerGui") or Instance.new("PlayerGui",LocalPlayer)

-- Tela de chave quadrada
local keyF=Instance.new("Frame")
keyF.Size=UDim2.new(0,250,0,250)
keyF.Position=UDim2.new(0.5,-125,0.5,-125)
keyF.BackgroundColor3=Color3.fromRGB(20,20,40)
keyF.BorderSizePixel=2
keyF.Active=true
keyF.Draggable=true
keyF.Parent=PlayerGui

-- Fundo espaço
local bg=Instance.new("ImageLabel")
bg.Size=UDim2.new(1,0,1,0)
bg.Position=UDim2.new(0,0,0,0)
bg.Image="rbxassetid://508521982" -- fundo espaço
bg.ScaleType=Enum.ScaleType.Crop
bg.BackgroundTransparency=1
bg.Parent=keyF

-- Título
local keyT=Instance.new("TextLabel")
keyT.Size=UDim2.new(1,0,0,30)
keyT.Text="🔑 Digite a chave"
keyT.TextSize=18
keyT.Font=Enum.Font.SourceSansBold
keyT.TextColor3=Color3.fromRGB(255,255,255)
keyT.BackgroundTransparency=1
keyT.Parent=keyF

-- Caixa de texto
local keyBox=Instance.new("TextBox")
keyBox.Size=UDim2.new(0,180,0,35)
keyBox.Position=UDim2.new(0.5,-90,0,60)
keyBox.PlaceholderText="Digite aqui..."
keyBox.Text=""
keyBox.TextSize=16
keyBox.Font=Enum.Font.SourceSans
keyBox.BackgroundColor3=Color3.fromRGB(255,255,255)
keyBox.TextColor3=Color3.fromRGB(0,0,0)
keyBox.Parent=keyF

-- LED rainbow
local led=Instance.new("Frame")
led.Size=UDim2.new(0,20,0,20)
led.Position=UDim2.new(0.5,95,0,60)
led.BorderSizePixel=0
led.Parent=keyF

-- Variáveis do LED
local hue=0
local correct=false
RunService.RenderStepped:Connect(function()
    if not correct then
        hue=(hue+0.01)%1
        led.BackgroundColor3=Color3.fromHSV(hue,1,1)
    end
end)

-- Botão enviar
local submit=Instance.new("TextButton")
submit.Size=UDim2.new(0,100,0,35)
submit.Position=UDim2.new(0.5,-50,0,110)
submit.Text="Verificar"
submit.TextSize=16
submit.Font=Enum.Font.SourceSansBold
submit.BackgroundColor3=Color3.fromRGB(0,153,255)
submit.TextColor3=Color3.fromRGB(255,255,255)
submit.Parent=keyF

-- Função para criar menu
function createMenu()
    local screenGui=Instance.new("ScreenGui")
    screenGui.Name="PedroScriptsMenu"
    screenGui.Parent=PlayerGui

    local mainF=Instance.new("Frame")
    mainF.Size=UDim2.new(0,250,0,200)
    mainF.Position=UDim2.new(0.3,0,0.3,0)
    mainF.BackgroundColor3=Color3.fromRGB(0,0,0)
    mainF.BorderSizePixel=2
    mainF.Active=true
    mainF.Draggable=true
    mainF.Parent=screenGui

    local title=Instance.new("TextLabel")
    title.Size=UDim2.new(1,-40,0,25)
    title.Position=UDim2.new(0,5,0,0)
    title.Text="Pedro Scripts"
    title.TextColor3=Color3.fromRGB(255,255,255)
    title.BackgroundTransparency=1
    title.TextSize=18
    title.Font=Enum.Font.SourceSansBold
    title.TextXAlignment=Enum.TextXAlignment.Left
    title.Parent=mainF

    local toggle=Instance.new("TextButton")
    toggle.Size=UDim2.new(0,35,0,25)
    toggle.Position=UDim2.new(1,-40,0,0)
    toggle.Text="-"
    toggle.TextSize=18
    toggle.Font=Enum.Font.SourceSansBold
    toggle.BackgroundColor3=Color3.fromRGB(255,0,0)
    toggle.TextColor3=Color3.fromRGB(255,255,255)
    toggle.Parent=mainF

    local scroll=Instance.new("ScrollingFrame")
    scroll.Size=UDim2.new(1,-10,1,-35)
    scroll.Position=UDim2.new(0,5,0,30)
    scroll.CanvasSize=UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness=6
    scroll.BackgroundTransparency=1
    scroll.Parent=mainF

    -- Função para criar botões rainbow
    local function createButton(name,callback)
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(1,-10,0,35)
        b.Text=name
        b.TextSize=16
        b.Font=Enum.Font.SourceSansBold
        b.TextColor3=Color3.fromRGB(255,255,255)
        b.BackgroundColor3=Color3.fromRGB(0,0,0)
        b.BorderSizePixel=0
        b.Parent=scroll

        local hue=0
        RunService.RenderStepped:Connect(function()
            hue=(hue+0.01)%1
            b.BackgroundColor3=Color3.fromHSV(hue,1,1)
        end)

        b.MouseButton1Click:Connect(callback)
        return b
    end

    -- Botões dos scripts
    local s1=createButton("Lennon v1",function()
        loadstring(game:HttpGet("https://pastefy.app/3R6JfM1r/raw"))()
    end)
    local s2=createButton("Lennon v2",function()
        loadstring(game:HttpGet("https://pastefy.app/1FPEhJmq/raw"))()
    end)
    local s3=createButton("Chilli",function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end)

    local buttons={s1,s2,s3}
    for i,btn in ipairs(buttons) do
        btn.Position=UDim2.new(0,5,0,(i-1)*40)
    end
    scroll.CanvasSize=UDim2.new(0,0,#buttons*40)

    -- Abrir/fechar menu
    local isOpen=true
    toggle.MouseButton1Click:Connect(function()
        isOpen=not isOpen
        scroll.Visible=isOpen
        toggle.Text=isOpen and "-" or "+"
    end)
end

-- Verificação da chave
submit.MouseButton1Click:Connect(function()
    if keyBox.Text=="Pedroscripts" then
        correct=true
        led.BackgroundColor3=Color3.fromRGB(0,255,0)
        keyF:Destroy()
        createMenu()
    else
        keyBox.Text=""
        keyBox.PlaceholderText="Chave incorreta!"
    end
end)

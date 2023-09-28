--[[ bibliotecas ]]
-- https://github.com/Ulydev/push/blob/master/push.lua
push = require 'push'


--[[ definição da altura e largura da janela do jogo]]
LARGURA_JANELA = 1280
ALTURA_JANELA = 720

LARGURA_VIRTUAL = 432
ALTURA_VIRTUAL = 243

VELOCIDADE_RAQUETE = 200 -- 200 pixels por segundo


--[[ inicialização]]
function love.load()
    -- def de filtro nearest como padrão para evitar o aspecto 'blur' do zoom
    love.graphics.setDefaultFilter('nearest', 'nearest')    
    -- setup fontes
    fonteP = love.graphics.newFont('Minecraftia-Regular.ttf', 8)
    fonteG = love.graphics.newFont('Minecraftia-Regular.ttf', 32)

    -- inicialização do placar
    placar1 = 0
    placar2 = 0

    -- inicialização das variaveis das raquetes
    ALTURA_RAQUETE = 26
    LARGURA_RAQUETE = 5
    raqueteEY = ALTURA_VIRTUAL/2 - ALTURA_RAQUETE/2
    raqueteDY = raqueteEY

    -- setup da janela com utilização da biblioteca push
    push:setupScreen(LARGURA_VIRTUAL, ALTURA_VIRTUAL, LARGURA_JANELA, ALTURA_JANELA, {
        fullscreen = false,
        resizable = false,
        vsync = true -- sincronizado com a taxa de refresh do monitor
    } -- tabela de parametros
)
end


--[[ definição de fechamento de janela ao pressionar a tecla escape]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end


--[[ updates]]
function love.update(dt)
    -- movimentos jogador esquerda
    if love.keyboard.isDown('w') then
        raqueteEY= raqueteEY - VELOCIDADE_RAQUETE*dt
    elseif love.keyboard.isDown('s') then
        raqueteEY= raqueteEY + VELOCIDADE_RAQUETE*dt
    end

    -- movimentos jogador direita
    if love.keyboard.isDown('up') then
        raqueteDY= raqueteDY - VELOCIDADE_RAQUETE*dt
    elseif love.keyboard.isDown('down') then
        raqueteDY= raqueteDY + VELOCIDADE_RAQUETE*dt
    end
end


--[[ renderização]]
function love.draw()
    push:apply('start')         -- aplica o zoom
    
    love.graphics.clear(164/255, 222/255, 191/255, 255/255)     -- background clear color

    -- bola
    love.graphics.rectangle('fill', LARGURA_VIRTUAL/2 - 2, ALTURA_VIRTUAL/2 - 2, 4, 4 ) 
    -- raquete esquerda
    love.graphics.rectangle('fill', 20, raqueteEY, LARGURA_RAQUETE, ALTURA_RAQUETE ) 
    -- raquete direita
    love.graphics.rectangle('fill', LARGURA_VIRTUAL - 25, raqueteDY, LARGURA_RAQUETE, ALTURA_RAQUETE ) 
    -- título
    love.graphics.setFont(fonteP)
    love.graphics.printf(
        'Hello Pong!',          -- texto
        0,                      -- x inicial
        20,                     -- y inicial (subtraindo 6 pois a fonte padrão tem altura 12)
        LARGURA_VIRTUAL,         -- parametro de alinhamento
        'center')               -- tipo de alinhamento
    -- placar
    love.graphics.setFont(fonteG)
    love.graphics.print(placar1, LARGURA_VIRTUAL/2 - 50, ALTURA_VIRTUAL/3)
    love.graphics.print(placar2, LARGURA_VIRTUAL/2 + 30, ALTURA_VIRTUAL/3)
    push:apply('end')           -- fim da aplicação de zoom
end



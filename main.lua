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
    -- random seed 
    math.randomseed(os.time())
    estadoJogo = 'inicio'
    -- def de filtro nearest como padrão para evitar o aspecto 'blur' do zoom
    love.graphics.setDefaultFilter('nearest', 'nearest')    
    -- setup fontes
    fonteP = love.graphics.newFont('Minecraftia-Regular.ttf', 8)
    fonteG = love.graphics.newFont('Minecraftia-Regular.ttf', 32)

    -- inicialização das variaveis das raquetes
    ALTURA_RAQUETE = 26
    LARGURA_RAQUETE = 5

    if estadoJogo == 'inicio' then
        -- inicialização do placar
        placar1 = 0
        placar2 = 0

        -- centraliza posição das raquetes
        raqueteEY = ALTURA_VIRTUAL/2 - ALTURA_RAQUETE/2
        raqueteDY = raqueteEY

        -- centraliza posição da bola
        bolaX = LARGURA_VIRTUAL/2 - 2
        bolaY =  ALTURA_VIRTUAL/2 - 2

        -- escolhe angulo de lanamento
        boladX = math.random(2) == 1 and 100 or -100
        boladY = math.random(2) == 1 and 50 or -50
    end
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
    elseif key == 'enter' or key == 'return' then 
        if estadoJogo == 'inicio' then
            estadoJogo = 'jogando'
        elseif estadoJogo == 'jogando' then
            estadoJogo = 'inicio'
        end
    end
end


--[[ updates]]
function love.update(dt)

    if estadoJogo == 'inicio' then
        -- inicialização do placar
        placar1 = 0
        placar2 = 0

        -- centraliza posição das raquetes
        raqueteEY = ALTURA_VIRTUAL/2 - ALTURA_RAQUETE/2
        raqueteDY = raqueteEY

        -- centraliza posição da bola
        bolaX = LARGURA_VIRTUAL/2 - 2
        bolaY =  ALTURA_VIRTUAL/2 - 2

        -- escolhe angulo de lanamento
        boladX = math.random(2) == 1 and 100 or -100
        boladY = math.random(2) == 1 and 50 or -50

    elseif estadoJogo == 'jogando' then 
        -- atualiza posição da bola 
        bolaX = bolaX + boladX*dt
        bolaY = bolaY + boladY*dt
        -- movimentos jogador esquerda
        if love.keyboard.isDown('w') then
            raqueteEY= math.max(0, raqueteEY - VELOCIDADE_RAQUETE*dt)
        elseif love.keyboard.isDown('s') then
            raqueteEY= math.min(ALTURA_VIRTUAL-ALTURA_RAQUETE, raqueteEY + VELOCIDADE_RAQUETE*dt)
        end

        -- movimentos jogador direita
        if love.keyboard.isDown('up') then
            raqueteDY= math.max(0, raqueteDY - VELOCIDADE_RAQUETE*dt)
        elseif love.keyboard.isDown('down') then
            raqueteDY= math.min(ALTURA_VIRTUAL-ALTURA_RAQUETE, raqueteDY + VELOCIDADE_RAQUETE*dt)
        end
    end
end


--[[ renderização]]
function love.draw()
    push:apply('start')         -- aplica o zoom
    
    love.graphics.clear(164/255, 222/255, 191/255, 255/255)     -- background clear color

    -- bola
    love.graphics.rectangle('fill', bolaX, bolaY, 4, 4 ) 
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



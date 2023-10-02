--[[ bibliotecas ]]
-- https://github.com/Ulydev/push/blob/master/push.lua
push = require 'push'
Class = require 'class'
require 'Raquete'
require 'Bola'

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
    AFASTAMENTO = 20

    raqueteE = Raquete(AFASTAMENTO, ALTURA_VIRTUAL/2 - ALTURA_RAQUETE/2, LARGURA_RAQUETE, ALTURA_RAQUETE)
    raqueteD = Raquete(LARGURA_VIRTUAL-(AFASTAMENTO+LARGURA_RAQUETE), ALTURA_VIRTUAL/2 - ALTURA_RAQUETE/2, LARGURA_RAQUETE, ALTURA_RAQUETE)

    -- inicialização das variaveis da bola
    ALTURA_BOLA = 4
    LARGURA_BOLA = 4

    bola = Bola(LARGURA_VIRTUAL/2 - LARGURA_BOLA/2, ALTURA_VIRTUAL/2 - ALTURA_BOLA/2, LARGURA_BOLA, ALTURA_BOLA)

    -- setup da janela com utilização da biblioteca push
    love.window.setTitle('Pong') -- titulo da janela

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

    raqueteE:update(dt)
    raqueteD:update(dt)

    if estadoJogo == 'inicio' then
        -- inicialização do placar
        placar1 = 0
        placar2 = 0

        -- centraliza posição das raquetes
        raqueteE:reset()
        raqueteD:reset()

        -- centraliza posição da bola
        bola:reset()


    elseif estadoJogo == 'jogando' then 

        -- atualiza posição da bola 
        bola:update(dt)

        -- movimentos jogador esquerda
        if love.keyboard.isDown('w') then
            raqueteE.dy = -VELOCIDADE_RAQUETE
        elseif love.keyboard.isDown('s') then
            raqueteE.dy = VELOCIDADE_RAQUETE
        else
            raqueteE.dy = 0
        end

        -- movimentos jogador direita
        if love.keyboard.isDown('up') then
            raqueteD.dy = -VELOCIDADE_RAQUETE
        elseif love.keyboard.isDown('down') then
            raqueteD.dy = VELOCIDADE_RAQUETE
        else
            raqueteD.dy = 0
        end
    end
end


--[[ renderização]]
function love.draw()
    push:apply('start')         -- aplica o zoom
    
    love.graphics.clear(164/255, 222/255, 191/255, 255/255)     -- background clear color

    -- colisão check
    if bola:colide(raqueteE) then
        bola.dx = -bola.dx
        bola.x = raqueteE.x + raqueteE.largura
    end

    if bola:colide(raqueteD) then
        bola.dx = -bola.dx
        bola.x = raqueteD.x - bola.largura 
    end

    if bola.y < 0 then
        bola.dy = -bola.dy
        bola.y = 0
    end

    if bola.y > ALTURA_VIRTUAL then
        bola.dy = -bola.dy
        bola.y = ALTURA_VIRTUAL - bola.altura
    end

    -- bola
    bola:render()
    -- raquete esquerda
    raqueteE:render() 
    -- raquete direita
    raqueteD:render()

    -- fps
    displayFPS()

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

-- função para mostrar fps
function displayFPS()
    love.graphics.setFont(fonteP)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 40, 20)
end

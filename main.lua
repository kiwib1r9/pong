-- definição da altura e largura da janela do jogo

LARGURA_JANELA = 1280
ALTURA_JANELA = 720

function love.load()
    love.window.setMode(LARGURA_JANELA, ALTURA_JANELA, {
        fullscreen = false,
        resizable = false,
        vsync = true -- sincronizado com a taxa de refresh do monitor
    } -- tabela de parametros
)
end

--[[
function love.update(dt)
end]]

function love.draw()
    love.graphics.printf(
        'Hello Pong!',          -- texto
        0,                      -- x inicial
        ALTURA_JANELA/2 - 6,    -- y inicial (subtraindo 6 pois a fonte padrão tem altura 12)
        LARGURA_JANELA,         -- parametro de alinhamento
        'center')               -- tipo de alinhamento
end



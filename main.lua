--[[ bibliotecas ]]
push = require 'push'


--[[ definição da altura e largura da janela do jogo]]
LARGURA_JANELA = 1280
ALTURA_JANELA = 720

LARGURA_VIRTUAL = 432
ALTURA_VIRTUAL = 243


--[[ inicialização]]
function love.load()
    -- def de filtro nearest como padrão para evitar o aspecto 'blur' do zoom
    love.graphics.setDefaultFilter('nearest', 'nearest')    
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


--[[
function love.update(dt)
end]]


--[[ renderização]]
function love.draw()
    push:apply('start')         -- aplica o zoom
    
    love.graphics.printf(
        'Hello Pong!',          -- texto
        0,                      -- x inicial
        ALTURA_VIRTUAL/2 - 6,    -- y inicial (subtraindo 6 pois a fonte padrão tem altura 12)
        LARGURA_VIRTUAL,         -- parametro de alinhamento
        'center')               -- tipo de alinhamento
    
    push:apply('end')           -- fim da aplicação de zoom
end



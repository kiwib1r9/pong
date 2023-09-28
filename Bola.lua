Bola = Class{}

function Bola:init(x, y, largura, altura)
    self.x = x
    self.y = y
    self.largura = largura
    self.altura = altura

    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(2) == 1 and 50 or -50
end

function Bola:reset()
    -- centraliza posição da bola
    self.x = LARGURA_VIRTUAL/2 - 2
    self.y =  ALTURA_VIRTUAL/2 - 2

    -- define angulo de lançamento
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(2) == 1 and 50 or -50
end


function Bola:update(dt)
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt
end

function Bola:render()
    love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
end
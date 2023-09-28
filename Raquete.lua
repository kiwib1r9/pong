Raquete = Class{}

function Raquete:init(x, y, largura, altura)
    self.x = x
    self.y = y
    self.largura = largura
    self.altura = altura

    self.dy = 0
end

function Raquete:reset()
    self.y = ALTURA_VIRTUAL/2 - self.altura/2
end


function Raquete:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy*dt)
    elseif self.dy > 0 then
        self.y = math.min(ALTURA_VIRTUAL-self.altura, self.y + self.dy*dt)
    end
end

function Raquete:render()
    love.graphics.rectangle('fill', self.x, self.y, self.largura, self.altura)
end

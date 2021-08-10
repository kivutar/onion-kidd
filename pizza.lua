local pizza = {}
pizza.__index = pizza

function NewPizza(n)
	n.type = ENT_PIZZA
	n.width = 16
	n.height = 16

	return setmetatable(n, pizza)
end

function pizza:draw()
	love.graphics.draw(IMG_pizza, self.x, self.y)
end

function pizza:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function pizza:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

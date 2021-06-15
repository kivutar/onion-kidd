local money = {}
money.__index = money

function NewMoney(n)
	n.type = ENT_MONEY
	n.width = 16
	n.height = 16

	return setmetatable(n, money)
end

function money:draw()
	love.graphics.draw(IMG_money, self.x, self.y)
end

function money:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function money:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

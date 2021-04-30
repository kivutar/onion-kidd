local ground = {}
ground.__index = ground

function newGround(n)
	n.type = ENT_GROUND
	n.width = 16
	n.height = 16
	n.img = IMG_ground

	local s = solid_at(n.x, n.y-1)

	if not s or s.type ~= ENT_GROUND then n.img = IMG_ground_top end

	return setmetatable(n, ground)
end

function ground:draw()
	love.graphics.draw(self.img, self.x, self.y)
end

function ground:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function ground:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

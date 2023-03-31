local ground = {}
ground.__index = ground

function NewGround(n)
	n.type = ENT_GROUND
	n.width = 16
	n.height = 16
	n.img = IMG_ground

	local up = MapGet(n.y/16, n.x/16+1)
	local down = MapGet(n.y/16+2, n.x/16+1)
	local left = MapGet(n.y/16+1, n.x/16)
	local right = MapGet(n.y/16+1, n.x/16+2)

	if left ~= nil and left ~= 1 then n.img = IMG_ground_left end
	if right ~= nil and right ~= 1 then n.img = IMG_ground_right end
	if down ~= nil and down ~= 1 then n.img = IMG_ground_down end
	if up ~= nil and up ~= 1 then n.img = IMG_ground_up end

	if up ~= nil and up ~= 1 and down ~= nil and down ~= 1 then n.img = IMG_ground_up_down end

	if left ~= nil and left ~= 1 and down ~= nil and down ~= 1 then n.img = IMG_ground_left_down end
	if right ~= nil and right ~= 1 and down ~= nil and down ~= 1 then n.img = IMG_ground_right_down end

	if left ~= nil and left ~= 1 and up ~= nil and up ~= 1 then n.img = IMG_ground_left_up end
	if right ~= nil and right ~= 1 and up ~= nil and up ~= 1 then n.img = IMG_ground_right_up end

	if left ~= nil and left ~= 1 and up ~= nil and up ~= 1 and down ~= nil and down ~= 1 then n.img = IMG_ground_left_up_down end
	if right ~= nil and right ~= 1 and up ~= nil and up ~= 1 and down ~= nil and down ~= 1 then n.img = IMG_ground_right_up_down end

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

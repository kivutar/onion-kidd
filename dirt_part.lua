local dirt_part = {}
dirt_part.__index = dirt_part

function newDirtPart(n)
	n.type = ENT_DIRT_PART
	n.width = 8
	n.height = 8
	n.yspeed = -2
	n.yaccel = 0.2
	n.t = 0

	return setmetatable(n, dirt_part)
end

function dirt_part:update(dt)
	self.t = self.t + 1
	self.yspeed = self.yspeed + self.yaccel
	self.x = self.x + self.xspeed
	self.y = self.y + self.yspeed
	if self.y > CAMERA.y+SCREEN_HEIGHT then effect_remove(self) end
end

function dirt_part:draw()
	if self.t % 2 == 0 then
		love.graphics.draw(IMG_dirt_part, self.x, self.y)
	end
end

function dirt_part:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
		yspeed = self.yspeed,
		yaccel = self.yaccel,
		xspeed = self.xspeed,
	}
end

function dirt_part:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
	self.yspeed = n.yspeed
	self.yaccel = n.yaccel
	self.xspeed = n.xspeed
end

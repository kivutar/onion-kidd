local punch = {}
punch.__index = punch

function NewPunch(n)
	n.type = ENT_PUNCH
	n.width = 16
	n.height = 16
	n.t = 20

	return setmetatable(n, punch)
end

function punch:update(dt)
	self.t = self.t - 1
	if self.t <= 0 then self:die() end
	SolidCollisions(self)
end

function punch:die()
	EntityRemove(self)
end

function punch:on_collide(e1, e2, dx, dy)
	if e2.type == ENT_DIRT or e2.type == ENT_STAR or e2.type == ENT_POWERBLOCK then
		e2:die()
	end
end

function punch:serialize()
	return {
		uid = self.uid,
		type = self.type,
		direction = self.direction,
		x = self.x,
		y = self.y,
		xspeed = self.xspeed,
	}
end

function punch:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.direction = n.direction
	self.x = n.x
	self.y = n.y
	self.xspeed = n.xspeed
end

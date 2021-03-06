local fireball = {}
fireball.__index = fireball

function NewFireball(n)
	n.type = ENT_FIREBALL
	n.width = 8
	n.height = 8
	if n.direction == DIR_LEFT then
		n.xspeed = -5
	else
		n.xspeed = 5
	end

	n.anim = NewAnimation(IMG_fireball, 16, 16, 1, 10)

	return setmetatable(n, fireball)
end

function fireball:update(dt)
	if self.direction == DIR_LEFT and self.xspeed > 0 then
		self.xspeed = 0
	end
	if self.direction == DIR_RIGHT and self.xspeed < 0 then
		self.xspeed = 0
	end
	self.x = self.x + self.xspeed

	self.anim:update(dt)
	SolidCollisions(self)
end

function fireball:draw()
	self.anim:draw(self.x-4, self.y-4)
end

function fireball:die()
	-- SFX_explode:play()
	-- table.insert(EFFECTS, NewFireballexp({uid=NewUID(),x=self.x,y=self.y}))
	EntityRemove(self)
end

function fireball:on_collide(e1, e2, dx, dy)
	if e2.type == ENT_GROUND then
		self:die()
	elseif e2.type == ENT_DIRT or e2.type == ENT_STAR or e2.type == ENT_POWERBLOCK then
		e2:die()
	end
end

function fireball:serialize()
	return {
		uid = self.uid,
		type = self.type,
		direction = self.direction,
		x = self.x,
		y = self.y,
		xspeed = self.xspeed,
	}
end

function fireball:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.direction = n.direction
	self.x = n.x
	self.y = n.y
	self.xspeed = n.xspeed
end

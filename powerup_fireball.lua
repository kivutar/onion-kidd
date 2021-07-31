local powerup_fireball = {}
powerup_fireball.__index = powerup_fireball

function NewPowerupFireball(n)
	n.type = ENT_POWERUP_FIREBALL
	n.width = 16
	n.height = 16

	n.anim = NewAnimation(IMG_powerup_fireball, 16, 16, 1, 2)

	return setmetatable(n, powerup_fireball)
end

function powerup_fireball:update(dt)
	self.anim:update(dt)
end

function powerup_fireball:draw()
	self.anim:draw(self.x, self.y)
end

function powerup_fireball:die()
	EntityRemove(self)
end

function powerup_fireball:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function powerup_fireball:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

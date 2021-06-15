local bird_part = {}
bird_part.__index = bird_part

function NewBirdPart(n)
	n.type = ENT_BIRD_PART
	n.width = 8
	n.height = 8
	n.yspeed = -2
	n.yaccel = 0.1
	n.t = 0

	n.anim = NewAnimation(IMG_bird_part, 8, 8, 1, 10)

	return setmetatable(n, bird_part)
end

function bird_part:update(dt)
	self.t = self.t + 1
	self.anim:update(dt)
	self.yspeed = self.yspeed + self.yaccel
	self.x = self.x + self.xspeed
	self.y = self.y + self.yspeed
	if self.y > CAMERA.y+SCREEN_HEIGHT then effect_remove(self) end
end

function bird_part:draw()
	if self.t % 2 == 0 then
		self.anim:draw(self.x, self.y)
	end
end

function bird_part:serialize()
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

function bird_part:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
	self.yspeed = n.yspeed
	self.yaccel = n.yaccel
	self.xspeed = n.xspeed
end

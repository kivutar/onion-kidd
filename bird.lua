local bird = {}
bird.__index = bird

function newBird(n)
	n.type = ENT_BIRD
	n.width = 28
	n.height = 16
	n.direction = DIR_RIGHT
	if n.direction == DIR_LEFT then
		n.xspeed = -0.5
	else
		n.xspeed = 0.5
	end
	n.yspeed = 0
	n.yaccel = 0.17
	n.xaccel = 0
	n.dead = false
	n.stance = "fly"

	n.animations = {
		fly = {
			[DIR_LEFT]  = newAnimation(IMG_bird_fly_left,  28, 16, 1, 10),
			[DIR_RIGHT] = newAnimation(IMG_bird_fly_right, 28, 16, 1, 10)
		},
		die = {
			[DIR_LEFT]  = newAnimation(IMG_bird_die_left,  28, 16, 1, 10),
			[DIR_RIGHT] = newAnimation(IMG_bird_die_right, 28, 16, 1, 10)
		},
	}

	n.anim = n.animations[n.stance][n.direction]

	return setmetatable(n, bird)
end

function bird:die()
	self.dead = true
	self.yspeed = -1
	self.stance = "die"
	SFX_enemy_die:play()
end

function bird:update(dt)
	if PHASE == "victory" then return end

	if self.dead then
		self.yspeed = self.yspeed + self.yaccel
		if (self.yspeed > 3) then self.yspeed = 3 end
		self.y = self.y + self.yspeed
		self.anim = self.animations[self.stance][self.direction]
		self.anim:update(dt)
		if self.y > CAMERA.y+SCREEN_HEIGHT then entity_remove(self) end
		return
	end

	self.xspeed = self.xspeed + self.xaccel

	self.x = self.x + self.xspeed

	self.anim = self.animations[self.stance][self.direction]
	self.anim:update(dt)
	solid_collisions(self)
end

function bird:draw()
	self.anim:draw(self.x, self.y)
end

function bird:on_collide(e1, e2, dx, dy)

	if self.dead then return end

	if e2.type == ENT_GROUND or e2.type == ENT_DIRT or e2.type == ENT_STAR then
		if math.abs(dy) < math.abs(dx) and ((dy < 0 and self.yspeed > 0) or (dy > 0 and self.yspeed < 0)) then
			self.yspeed = 0
			self.y = self.y + dy
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.x = self.x + dx
			if self.direction == DIR_RIGHT then self.direction = DIR_LEFT
			elseif self.direction == DIR_LEFT then self.direction = DIR_RIGHT end
			self.xspeed = -self.xspeed
		end
	elseif e2.type == ENT_FIREBALL then
		self:die()
	end
end

function bird:serialize()
	return {
		uid = self.uid,
		type = self.type,
		direction = self.direction,
		x = self.x,
		y = self.y,
		xspeed = self.xspeed,
		xaccel = self.xaccel,
		yspeed = self.yspeed,
		yaccel = self.yaccel,
		dead = self.dead,
		stance = self.stance,
	}
end

function bird:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.direction = n.direction
	self.x = n.x
	self.y = n.y
	self.xspeed = n.xspeed
	self.xaccel = n.xaccel
	self.yspeed = n.yspeed
	self.yaccel = n.yaccel
	self.dead = n.dead
	self.stance = n.stance
end

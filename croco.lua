local croco = {}
croco.__index = croco

function newCroco(n)
	n.type = ENT_CROCO
	n.width = 16
	n.height = 16
	n.direction = DIR_RIGHT
	if n.direction == DIR_LEFT then
		n.xspeed = -1
	else
		n.xspeed = 1
	end
	n.yspeed = 0
	n.yaccel = 0.17
	n.xaccel = 0
	n.dead = false
	n.stance = "run"

	n.animations = {
		run = {
			[DIR_LEFT]  = newAnimation(IMG_croco_run_left,  24, 24, 1, 10),
			[DIR_RIGHT] = newAnimation(IMG_croco_run_right, 24, 24, 1, 10)
		},
		die = {
			[DIR_LEFT]  = newAnimation(IMG_croco_die_left,  24, 24, 1, 10),
			[DIR_RIGHT] = newAnimation(IMG_croco_die_right, 24, 24, 1, 10)
		},
	}

	n.anim = n.animations[n.stance][n.direction]

	return setmetatable(n, croco)
end

function croco:on_the_ground()
	return solid_at(self.x + 1, self.y + 16, self)
		or solid_at(self.x + 15, self.y + 16, self)
end

function croco:die()
	self.dead = true
	self.yspeed = -1
	self.stance = "die"
	SFX_enemy_die:play()
end

function croco:update(dt)
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

	local otg = self:on_the_ground()

	self.xspeed = self.xspeed + self.xaccel
	self.yspeed = self.yspeed + self.yaccel
	if (self.yspeed > 3) then self.yspeed = 3 end
	if otg and self.yspeed > 0 then self.yspeed = 0 end

	self.x = self.x + self.xspeed
	self.y = self.y + self.yspeed

	self.anim = self.animations[self.stance][self.direction]
	self.anim:update(dt)
	solid_collisions(self)
end

function croco:draw()
	self.anim:draw(self.x-6, self.y-8)
end

function croco:on_collide(e1, e2, dx, dy)

	if self.dead then return end

	if e2.type == ENT_GROUND or e2.type == ENT_DIRT or e2.type == ENT_STAR or e2.type == ENT_POWERBLOCK then
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
	elseif e2.type == ENT_FIREBALL or e2.type == ENT_PUNCH then
		self:die()
	end
end

function croco:serialize()
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

function croco:unserialize(n)
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

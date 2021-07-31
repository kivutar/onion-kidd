local character = {}
character.__index = character

JUMP_FORGIVENESS = 8

function NewCharacter(n)
	n.type = ENT_CHARACTER
	n.width = 10
	n.height = 16
	n.xspeed = 0
	n.yspeed = 0
	n.xaccel = 0.5
	n.yaccel = 0.15
	if n.direction == nil then n.direction = DIR_RIGHT end
	n.stance = "jump"
	n.DO_JUMP = 0
	n.DO_ATTACK = 0
	n.speedlimit = 2
	n.ko = 0
	n.dead_t = 0
	n.dead = false
	n.ungrounded_time = 0

	if n.pad == 1 then
		n.animations = {
			stand = {
				[DIR_LEFT]  = NewAnimation(IMG_turnip_stand_left,  24, 24, 2, 10),
				[DIR_RIGHT] = NewAnimation(IMG_turnip_stand_right, 24, 24, 2, 10)
			},
			run = {
				[DIR_LEFT]  = NewAnimation(IMG_turnip_run_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_turnip_run_right, 24, 24, 1, 10)
			},
			attack = {
				[DIR_LEFT]  = NewAnimation(IMG_turnip_attack_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_turnip_attack_right, 24, 24, 1, 10)
			},
			jump = {
				[DIR_LEFT]  = NewAnimation(IMG_turnip_jump_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_turnip_jump_right, 24, 24, 1, 10)
			},
			fall = {
				[DIR_LEFT]  = NewAnimation(IMG_turnip_fall_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_turnip_fall_right, 24, 24, 1, 10)
			},
			ko = {
				[DIR_LEFT]  = NewAnimation(IMG_turnip_ko_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_turnip_ko_right, 24, 24, 1, 10)
			},
			die = {
				[DIR_LEFT]  = NewAnimation(IMG_turnip_die_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_turnip_die_right, 24, 24, 1, 10)
			},
		}
	elseif n.pad == 2 then
		n.animations = {
			stand = {
				[DIR_LEFT]  = NewAnimation(IMG_girl_stand_left,  24, 24, 2, 10),
				[DIR_RIGHT] = NewAnimation(IMG_girl_stand_right, 24, 24, 2, 10)
			},
			run = {
				[DIR_LEFT]  = NewAnimation(IMG_girl_run_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_girl_run_right, 24, 24, 1, 10)
			},
			attack = {
				[DIR_LEFT]  = NewAnimation(IMG_girl_attack_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_girl_attack_right, 24, 24, 1, 10)
			},
			jump = {
				[DIR_LEFT]  = NewAnimation(IMG_girl_jump_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_girl_jump_right, 24, 24, 1, 10)
			},
			fall = {
				[DIR_LEFT]  = NewAnimation(IMG_girl_fall_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_girl_fall_right, 24, 24, 1, 10)
			},
			ko = {
				[DIR_LEFT]  = NewAnimation(IMG_girl_ko_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_girl_ko_right, 24, 24, 1, 10)
			},
			die = {
				[DIR_LEFT]  = NewAnimation(IMG_girl_die_left,  24, 24, 1, 10),
				[DIR_RIGHT] = NewAnimation(IMG_girl_die_right, 24, 24, 1, 10)
			},
		}
	end

	n.anim = n.animations[n.stance][n.direction]

	return setmetatable(n, character)
end

function character:on_the_ground()
	return solid_at(self.x + 1, self.y + self.height)
		or solid_at(self.x + self.width - 1, self.y + self.height)
end

function character:die()
	self.dead = true
	self.dead_t = 240
	self.yspeed = -1
	self.stance = "die"
	SFX_die:play()
end

function character:update(dt)
	if PHASE == "victory" then return end

	if self.dead_t > 0 then
		if self.dead_t < 180 then
			self.yspeed = self.yspeed + self.yaccel
			if (self.yspeed > 3) then self.yspeed = 3 end
			self.y = self.y + self.yspeed
		end
		self.anim = self.animations[self.stance][self.direction]
		self.anim:update(dt)
		if self.y > CAMERA.y+SCREEN_HEIGHT then
			EntityRemove(self)
			CAMERA = {
				x = 0,
				y = 0,
			}
			BGM:stop()
			STAGE = 1
			ENTITIES = {}
			SOLIDS = {}
			EFFECTS = {}
			MAP = {}
			LAST_UID = 0
			HAS_FIREBALL = false
			POINTS = 0
			table.insert(ENTITIES, NewTitle({}))
		end
		self.dead_t = self.dead_t - 1
		return
	end

	local otg = self:on_the_ground()

	local JOY_LEFT  = love.joystick.isDown(self.pad, RETRO_DEVICE_ID_JOYPAD_LEFT)
	local JOY_RIGHT = love.joystick.isDown(self.pad, RETRO_DEVICE_ID_JOYPAD_RIGHT)
	local JOY_DOWN = love.joystick.isDown(self.pad, RETRO_DEVICE_ID_JOYPAD_DOWN)
	local JOY_B = love.joystick.isDown(self.pad, RETRO_DEVICE_ID_JOYPAD_B)
	local JOY_A = love.joystick.isDown(self.pad, RETRO_DEVICE_ID_JOYPAD_A)

	-- gravity
	self.yspeed = self.yspeed + self.yaccel
	if (self.yspeed > 3) then self.yspeed = 3 end
	if otg and self.yspeed > 0 then self.yspeed = 0 end

	-- jumping
	if JOY_B then
		self.DO_JUMP = self.DO_JUMP + 1
	else
		self.DO_JUMP = 0
	end

	if otg then
		self.ungrounded_time = 0
	else
		self.ungrounded_time = self.ungrounded_time + 1
	end

	if self.DO_JUMP == 1 and not JOY_DOWN then
		if self.ungrounded_time < JUMP_FORGIVENESS then
			self.y = self.y - 1
			self.yspeed = -2.5
			SFX_jump:play()
		end
	end

	-- variable jump height
	if self.DO_JUMP > 0 and self.DO_JUMP <= 40 and self.yspeed < 0 then
		self.yspeed =  self.yspeed - 0.1
	end

	-- attacking
	if JOY_A then
		self.DO_ATTACK = self.DO_ATTACK + 1
	else
		self.DO_ATTACK = 0
	end

	if self.DO_ATTACK == 1 then
		if HAS_FIREBALL then
			SFX_fireball:play()
			if self.direction == DIR_LEFT then
				table.insert(ENTITIES, NewFireball({uid=NewUID(),x=self.x-8,y=self.y+4,direction=self.direction}))
			else
				table.insert(ENTITIES, NewFireball({uid=NewUID(),x=self.x+16,y=self.y+4,direction=self.direction}))
			end
		else
			SFX_punch:play()
			if self.direction == DIR_LEFT then
				table.insert(ENTITIES, NewPunch({uid=NewUID(),x=self.x-16,y=self.y,direction=self.direction}))
			else
				table.insert(ENTITIES, NewPunch({uid=NewUID(),x=self.x+self.width,y=self.y,direction=self.direction}))
			end
		end
	end

	-- moving
	if JOY_LEFT then
		self.xspeed = self.xspeed - self.xaccel
		if self.xspeed < -self.speedlimit then
			self.xspeed = -self.speedlimit
		end
		self.direction = DIR_LEFT
	end

	if JOY_RIGHT then
		self.xspeed = self.xspeed + self.xaccel
		if self.xspeed > self.speedlimit then
			self.xspeed = self.speedlimit
		end
		self.direction = DIR_RIGHT
	end

	-- apply speed
	self.x = self.x + self.xspeed
	self.y = self.y + self.yspeed

	if self.x <= 0 then self.x = 0 end
	if self.x >= SCREEN_WIDTH-self.width then self.x = SCREEN_WIDTH-self.width end

	-- decelerating
	if  ((not JOY_RIGHT and self.xspeed > 0)
	or  (not JOY_LEFT  and self.xspeed < 0))
	and otg
	then
		if self.xspeed > 0 then
			self.xspeed = self.xspeed - 10
			if self.xspeed < 0 then
				self.xspeed = 0
			end
		elseif self.xspeed < 0 then
			self.xspeed = self.xspeed + 10
			if self.xspeed > 0 then
				self.xspeed = 0
			end
		end
	end

	-- air friction
	if  ((not JOY_RIGHT and self.xspeed > 0)
	or  (not JOY_LEFT  and self.xspeed < 0))
	and not otg
	then
		if self.xspeed > 0 then
			self.xspeed = self.xspeed - 0.05
			if self.xspeed < 0 then
				self.xspeed = 0
			end
		elseif self.xspeed < 0 then
			self.xspeed = self.xspeed + 0.05
			if self.xspeed > 0 then
				self.xspeed = 0
			end
		end
	end

	if self.ko > 0 then self.ko = self.ko - 1 end

	-- animations
	if self.ko > 0 then
		self.stance = "ko"
	elseif self.DO_ATTACK > 0 and self.DO_ATTACK < 30 then
		self.stance = "attack"
	elseif otg then
		if self.xspeed == 0 then
			self.stance = "stand"
		else
			self.stance = "run"
		end
	else
		if self.yspeed < 0 then
			self.stance = "jump"
		else
			self.stance = "fall"
		end
	end

	local anim = self.animations[self.stance][self.direction]
	-- always animate from first frame
	if anim ~= self.anim then
		anim.timer = 0
	end
	self.anim = anim

	self.anim:update(dt)

	solid_collisions(self)

	local newcamy = self.y - SCREEN_HEIGHT/2 + self.height/2
	if newcamy > CAMERA.y then
		CAMERA.y = self.y - SCREEN_HEIGHT/2 + self.height/2
		if CAMERA.y <= 0 then CAMERA.y = 0 end
		if CAMERA.y >= #MAP*16 - SCREEN_HEIGHT then CAMERA.y = #MAP*16 - SCREEN_HEIGHT end
	end
end

function character:draw()
	self.anim:draw(self.x-7, self.y-8)
end

function character:on_collide(e1, e2, dx, dy)

	if self.dead then return end

	if e2.type == ENT_GROUND or e2.type == ENT_STAR or e2.type == ENT_DIRT or e2.type == ENT_POWERBLOCK then
		if math.abs(dy) < math.abs(dx) and ((dy < 0 and self.yspeed > 0) or (dy > 0 and self.yspeed < 0)) then
			self.yspeed = 0
			self.y = self.y + dy
		end
		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx
		end
	elseif e2.type == ENT_CHARACTER then
		if math.abs(dy) < math.abs(dx) and ((dy < 0 and self.yspeed > 0) or (dy > 0 and self.yspeed < 0)) then
			self.yspeed = -1
			self.y = self.y + dy
			SFX_ko:play()
			e2.ko = 10
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx/2
		end
	elseif (e2.type == ENT_CROCO or e2.type == ENT_BIRD) and not e2.dead then
		self:die()
	elseif e2.type == ENT_MONEY then
		SFX_gem:play()
		table.insert(EFFECTS, NewNotif({uid=NewUID(),x=e2.x, y=e2.y, text="100"}))
		POINTS = POINTS + 100
		EntityRemove(e2)
	elseif e2.type == ENT_POWERUP_FIREBALL then
		SFX_powerup:play()
		table.insert(EFFECTS, NewNotif({uid=NewUID(),x=e2.x, y=e2.y, text="500"}))
		POINTS = POINTS + 500
		EntityRemove(e2)
		HAS_FIREBALL = true
	end
end

function character:serialize()
	return {
		uid = self.uid,
		type = self.type,
		pad = self.pad,
		direction = self.direction,
		x = self.x,
		y = self.y,
		xspeed = self.xspeed,
		xaccel = self.xaccel,
		yspeed = self.yspeed,
		yaccel = self.yaccel,
		ko = self.ko,
		dead_t = self.dead_t,
		ungrounded_time = self.ungrounded_time,
		dead = self.dead,
		stance = self.stance,
		DO_JUMP = self.DO_JUMP,
		DO_ATTACK = self.DO_ATTACK,
	}
end

function character:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.direction = n.direction
	self.pad = n.pad
	self.x = n.x
	self.y = n.y
	self.xspeed = n.xspeed
	self.xaccel = n.xaccel
	self.yspeed = n.yspeed
	self.yaccel = n.yaccel
	self.ko = n.ko
	self.dead_t = n.dead_t
	self.ungrounded_time = n.ungrounded_time
	self.dead = n.dead
	self.stance = n.stance
	self.DO_JUMP = n.DO_JUMP
	self.DO_ATTACK = n.DO_ATTACK
end

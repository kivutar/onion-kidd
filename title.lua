local title = {}
title.__index = title

function newTitle(n)
	n.type = ENT_TITLE
	n.t = 0
	n.PRESSED = 0
	return setmetatable(n, title)
end

function title:update(dt)
	local JOY_START = love.joystick.isDown(1, RETRO_DEVICE_ID_JOYPAD_START)

	if JOY_START then
		self.PRESSED = self.PRESSED + 1
	end

	if self.PRESSED == 1 then
		SFX_ok:play()
		self.t = 60
	end

	if self.t > 0 then
		self.t = self.t - 1
		if self.t == 1 then
			ENTITIES = {}
			SOLIDS = {}
			EFFECTS = {}
			SHADOWS = {}
			MAP = {}
			LAST_UID = 0

			load_map(STAGES[STAGE])

			CHAR1 = newCharacter({uid=newUID(),x=1*16,y=6*16,pad=1,direction=DIR_RIGHT})
			--CHAR2 = newCharacter({uid=newUID(),x=18*16,y=4*16,pad=2,direction=DIR_LEFT})
			table.insert(ENTITIES, CHAR1)
			--table.insert(ENTITIES, CHAR2)
			-- table.insert(ENTITIES, newCharacter({x=3*16,y=7*16,pad=3}))

			BGM:play()
		end
	end
end

function title:draw()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	love.graphics.setFont(FNT_letters)
	local w = FNT_letters:getWidth("PRESS START")
	love.graphics.setColor(1, 1, 1, 1)
	if self.t/2 % 2 == 0 then
		love.graphics.print("PRESS START", math.floor(SCREEN_WIDTH/2 - w/2), math.floor(SCREEN_HEIGHT/2 - 16/2))
	end
end

function title:serialize()
	return {
		uid = self.uid,
		type = self.type,
		t = self.t,
		PRESSED = self.PRESSED,
	}
end

function title:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.t = n.t
	self.PRESSED = n.PRESSED
end

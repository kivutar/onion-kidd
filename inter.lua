local inter = {}
inter.__index = inter

function NewInter(n)
	n.type = ENT_INTER
	n.t = 100
	n.x = 0
	n.y = 0
	n.width = SCREEN_WIDTH
	n.height = SCREEN_HEIGHT
	BGM:stop()
	return setmetatable(n, inter)
end

function inter:update(dt)
	if self.t > 0 then
		self.t = self.t - 1
		if self.t == 1 then
			SOLIDS = {}
			ENTITIES = {}
			EFFECTS = {}
			PHASE = "game"
			STAGE = STAGE + 1
			CHAR1 = nil
			CHAR2 = nil
			LAST_UID = 0
			POINTS = 0
			CAMERA = {
				x = 0,
				y = 0,
			}

			LoadMap(STAGES[STAGE])

			CHAR1 = NewCharacter({uid=NewUID(),x=1*16,y=6*16,pad=1,direction=DIR_RIGHT})
			CHAR2 = NewCharacter({uid=NewUID(),x=2*16,y=6*16,pad=2,direction=DIR_RIGHT})
			table.insert(ENTITIES, CHAR1)
			table.insert(ENTITIES, CHAR2)
			BGM:play()
		end
	end
end

function inter:draw()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	love.graphics.setFont(FNT_letters)
	local w = FNT_letters:getWidth("STAGE "..STAGE.."! READY ?")
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("STAGE "..STAGE.."! READY?", math.floor(SCREEN_WIDTH/2 - w/2), math.floor(SCREEN_HEIGHT/2 - 16/2))
end

function inter:serialize()
	return {
		uid = self.uid,
		type = self.type,
		t = self.t,
	}
end

function inter:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.t = n.t
end

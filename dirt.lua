local dirt = {}
dirt.__index = dirt

function newDirt(n)
	n.type = ENT_DIRT
	n.width = 16
	n.height = 16
	n.img = IMG_dirt

	return setmetatable(n, dirt)
end

function dirt:draw()
	love.graphics.draw(self.img, self.x, self.y)
end

function dirt:die()
	--table.insert(EFFECTS, newNotif({uid=newUID(),x=self.x, y=self.y, text="100"}))
	love.audio.play(SFX_dirt_die)
	--table.insert(EFFECTS, newFireballexp({uid=newUID(),x=self.x,y=self.y}))
	solid_remove(self)
end

function dirt:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function dirt:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

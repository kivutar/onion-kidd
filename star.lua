local star = {}
star.__index = star

function newStar(n)
	n.type = ENT_STAR
	n.width = 16
	n.height = 16
	n.img = IMG_star

	return setmetatable(n, star)
end

function star:draw()
	love.graphics.draw(self.img, self.x, self.y)
end

function star:die()
	--table.insert(EFFECTS, newNotif({uid=newUID(),x=self.x, y=self.y, text="100"}))
	love.audio.play(SFX_dirt_die)
	table.insert(ENTITIES, newMoney({uid=newUID(),x=self.x,y=self.y}))
	solid_remove(self)
end

function star:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function star:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

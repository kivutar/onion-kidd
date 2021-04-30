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
	SFX_dirt_die:play()
	table.insert(ENTITIES, newMoney({uid=newUID(),x=self.x,y=self.y}))
	table.insert(EFFECTS, newDirtPart({uid=newUID(),x=self.x,y=self.y,xspeed=-0.5}))
	table.insert(EFFECTS, newDirtPart({uid=newUID(),x=self.x+8,y=self.y,xspeed=0.5}))
	table.insert(EFFECTS, newDirtPart({uid=newUID(),x=self.x,y=self.y+8,xspeed=-0.25}))
	table.insert(EFFECTS, newDirtPart({uid=newUID(),x=self.x+8,y=self.y+8,xspeed=0.25}))
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

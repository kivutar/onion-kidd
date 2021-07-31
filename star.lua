local star = {}
star.__index = star

function NewStar(n)
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
	SFX_dirt_die:play()
	table.insert(ENTITIES, NewMoney({uid=NewUID(),x=self.x,y=self.y}))
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x,y=self.y,xspeed=-0.5}))
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x+8,y=self.y,xspeed=0.5}))
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x,y=self.y+8,xspeed=-0.25}))
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x+8,y=self.y+8,xspeed=0.25}))
	SolidRemove(self)
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

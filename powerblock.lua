local powerblock = {}
powerblock.__index = powerblock

function NewPowerblock(n)
	n.type = ENT_POWERBLOCK
	n.width = 16
	n.height = 16
	n.img = IMG_powerblock

	return setmetatable(n, powerblock)
end

function powerblock:draw()
	love.graphics.draw(self.img, self.x, self.y)
end

function powerblock:die()
	SFX_dirt_die:play()
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x,y=self.y,xspeed=-0.5}))
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x+8,y=self.y,xspeed=0.5}))
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x,y=self.y+8,xspeed=-0.25}))
	table.insert(EFFECTS, NewDirtPart({uid=NewUID(),x=self.x+8,y=self.y+8,xspeed=0.25}))
	table.insert(ENTITIES, NewPowerupFireball({uid=NewUID(),x=self.x,y=self.y}))
	solid_remove(self)
end

function powerblock:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function powerblock:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

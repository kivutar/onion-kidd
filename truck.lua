local truck = {}
truck.__index = truck

function NewTruck(n)
	n.type = ENT_TRUCK
	n.width = 32+8
	n.height = 32
	n.anim = NewAnimation(IMG_truck, 32+8, 32, 1, 10)

	return setmetatable(n, truck)
end

function truck:update(dt)
	self.anim:update(dt)
end

function truck:draw()
	self.anim:draw(self.x, self.y+1)
end

function truck:die()

end

function truck:serialize()
	return {
		uid = self.uid,
		type = self.type,
		x = self.x,
		y = self.y,
	}
end

function truck:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.x = n.x
	self.y = n.y
end

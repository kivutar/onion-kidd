local notif = {}
notif.__index = notif

function NewNotif(n)
	n.type = ENT_NOTIF
	n.y = n.y - 16
	n.yspeed = -2
	n.yaccel = 0.1
	n.t = 0

	return setmetatable(n, notif)
end

function notif:update(dt)
	self.t = self.t + 1

	self.yspeed = self.yspeed + self.yaccel
	if self.yspeed >= 0 then self.yspeed = 0 end
	self.y = self.y + self.yspeed

	if self.t >= 60 then
		EffectRemove(self)
	end
end

function notif:draw()
	love.graphics.setFont(FNT_points)

	if self.t % 2 == 0 then
		love.graphics.print(self.text, math.floor(self.x), math.floor(self.y))
	end
end

function notif:serialize()
	return {
		uid = self.uid,
		type = self.type,
		text = self.text,
		x = self.x,
		y = self.y,
		yspeed = self.yspeed,
		yaccel = self.yaccel,
	}
end

function notif:unserialize(n)
	self.uid = n.uid
	self.type = n.type
	self.text = n.text
	self.x = n.x
	self.y = n.y
	self.yspeed = n.yspeed
	self.yaccel = n.yaccel
end

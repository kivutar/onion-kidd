-- entity types
ENT_CHARACTER = 1
ENT_GROUND = 2
ENT_STAR = 3
ENT_DIRT = 4
ENT_CROCO = 5
ENT_FIREBALL = 6
ENT_MONEY= 7
ENT_DIRT_PART= 8
ENT_BIRD = 9
ENT_NOTIF = 10
ENT_BRIDGE = 11
ENT_TITLE = 12
ENT_POWERBLOCK = 13
ENT_POWERUP_FIREBALL = 14
ENT_PUNCH = 15
ENT_NOTIF = 16
ENT_BIRD_PART= 17

DIR_UP    = 1
DIR_DOWN  = 2
DIR_LEFT  = 3
DIR_RIGHT = 4

function NewUID()
	LAST_UID = LAST_UID + 1
	return LAST_UID
end

function EffectRemove(e)
	for i=1, #EFFECTS do
		if EFFECTS[i] == e then
			table.remove(EFFECTS, i)
		end
	end
end

function EntityRemove(e)
	for i=1, #ENTITIES do
		if ENTITIES[i] == e then
			table.remove(ENTITIES, i)
		end
	end
end

function SolidRemove(e)
	for i=1, #SOLIDS do
		if SOLIDS[i] == e then
			table.remove(SOLIDS, i)
		end
	end
end

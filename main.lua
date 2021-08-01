require "global"
require "utils"
require "anim"
require "collisions"
require "entities"
require "character"
require "ground"
require "dirt"
require "star"
require "maps"
require "title"
require "croco"
require "fireball"
require "money"
require "dirt_part"
require "slam"
require "bird"
require "powerblock"
require "powerup_fireball"
require "punch"
require "notif"
require "bird_part"
Json = require "json"

function love.conf(t)
	t.width  = SCREEN_WIDTH
	t.height = SCREEN_HEIGHT
end

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setDefaultFilter("nearest", "nearest")

	IMG_ground = love.graphics.newImage("assets/ground.png")
	IMG_ground_up = love.graphics.newImage("assets/ground_up.png")
	IMG_ground_down = love.graphics.newImage("assets/ground_down.png")
	IMG_ground_left = love.graphics.newImage("assets/ground_left.png")
	IMG_ground_right = love.graphics.newImage("assets/ground_right.png")
	IMG_ground_up_down = love.graphics.newImage("assets/ground_up_down.png")
	IMG_ground_left_down = love.graphics.newImage("assets/ground_left_down.png")
	IMG_ground_right_down = love.graphics.newImage("assets/ground_right_down.png")
	IMG_ground_left_up_down = love.graphics.newImage("assets/ground_left_up_down.png")
	IMG_ground_right_up_down = love.graphics.newImage("assets/ground_right_up_down.png")
	IMG_bg = love.graphics.newImage("assets/bg.png")
	IMG_bouncer = love.graphics.newImage("assets/bouncer.png")
	IMG_bridge = love.graphics.newImage("assets/bridge.png")
	IMG_fireball = love.graphics.newImage("assets/fireball.png")
	IMG_bubbleexp = love.graphics.newImage("assets/bubble_explode.png")
	IMG_money = love.graphics.newImage("assets/money.png")
	IMG_star = love.graphics.newImage("assets/star.png")
	IMG_dirt = love.graphics.newImage("assets/dirt.png")
	IMG_dirt_part = love.graphics.newImage("assets/dirt_part.png")
	IMG_bird_part = love.graphics.newImage("assets/bird_part.png")
	IMG_powerblock = love.graphics.newImage("assets/powerblock.png")
	IMG_powerup_fireball = love.graphics.newImage("assets/powerup_fireball.png")

	IMG_turnip_stand_left = love.graphics.newImage("assets/turnip_stand_left.png")
	IMG_turnip_stand_right = love.graphics.newImage("assets/turnip_stand_right.png")
	IMG_turnip_run_left = love.graphics.newImage("assets/turnip_run_left.png")
	IMG_turnip_run_right = love.graphics.newImage("assets/turnip_run_right.png")
	IMG_turnip_attack_left = love.graphics.newImage("assets/turnip_attack_left.png")
	IMG_turnip_attack_right = love.graphics.newImage("assets/turnip_attack_right.png")
	IMG_turnip_jump_left = love.graphics.newImage("assets/turnip_jump_left.png")
	IMG_turnip_jump_right = love.graphics.newImage("assets/turnip_jump_right.png")
	IMG_turnip_fall_left = love.graphics.newImage("assets/turnip_fall_left.png")
	IMG_turnip_fall_right = love.graphics.newImage("assets/turnip_fall_right.png")
	IMG_turnip_ko_left = love.graphics.newImage("assets/turnip_die_left.png")
	IMG_turnip_ko_right = love.graphics.newImage("assets/turnip_die_right.png")
	IMG_turnip_die_left = love.graphics.newImage("assets/turnip_die_left.png")
	IMG_turnip_die_right = love.graphics.newImage("assets/turnip_die_right.png")

	IMG_girl_stand_left = love.graphics.newImage("assets/girl_stand_left.png")
	IMG_girl_stand_right = love.graphics.newImage("assets/girl_stand_right.png")
	IMG_girl_run_left = love.graphics.newImage("assets/girl_run_left.png")
	IMG_girl_run_right = love.graphics.newImage("assets/girl_run_right.png")
	IMG_girl_attack_left = love.graphics.newImage("assets/girl_attack_left.png")
	IMG_girl_attack_right = love.graphics.newImage("assets/girl_attack_right.png")
	IMG_girl_jump_left = love.graphics.newImage("assets/girl_jump_left.png")
	IMG_girl_jump_right = love.graphics.newImage("assets/girl_jump_right.png")
	IMG_girl_fall_left = love.graphics.newImage("assets/girl_fall_left.png")
	IMG_girl_fall_right = love.graphics.newImage("assets/girl_fall_right.png")
	IMG_girl_ko_left = love.graphics.newImage("assets/girl_die_left.png")
	IMG_girl_ko_right = love.graphics.newImage("assets/girl_die_right.png")
	IMG_girl_die_left = love.graphics.newImage("assets/girl_die_left.png")
	IMG_girl_die_right = love.graphics.newImage("assets/girl_die_right.png")

	IMG_croco_stand_left = love.graphics.newImage("assets/croco_stand_left.png")
	IMG_croco_stand_right = love.graphics.newImage("assets/croco_stand_right.png")
	IMG_croco_run_left = love.graphics.newImage("assets/croco_run_left.png")
	IMG_croco_run_right = love.graphics.newImage("assets/croco_run_right.png")
	IMG_croco_jump_left = love.graphics.newImage("assets/croco_jump_left.png")
	IMG_croco_jump_right = love.graphics.newImage("assets/croco_jump_right.png")
	IMG_croco_fall_left = love.graphics.newImage("assets/croco_fall_left.png")
	IMG_croco_fall_right = love.graphics.newImage("assets/croco_fall_right.png")
	IMG_croco_ko_left = love.graphics.newImage("assets/croco_die_left.png")
	IMG_croco_ko_right = love.graphics.newImage("assets/croco_die_right.png")
	IMG_croco_die_left = love.graphics.newImage("assets/croco_die_left.png")
	IMG_croco_die_right = love.graphics.newImage("assets/croco_die_right.png")

	IMG_bird_fly_left = love.graphics.newImage("assets/bird_fly_left.png")
	IMG_bird_fly_right = love.graphics.newImage("assets/bird_fly_right.png")
	IMG_bird_die_left = love.graphics.newImage("assets/bird_die_left.png")
	IMG_bird_die_right = love.graphics.newImage("assets/bird_die_right.png")

	BGM_bgm = NewSource("assets/medallion.ogg", "stream")

	SFX_jump = NewSource("assets/jump.wav", "static")
	SFX_explode = NewSource("assets/explode.wav", "static")
	SFX_ko = NewSource("assets/ko.wav", "static")
	SFX_fireball = NewSource("assets/fireball.wav", "static")
	SFX_enemy_die = NewSource("assets/enemy_die.wav", "static")
	SFX_dirt_die = NewSource("assets/dirt_die.wav", "static")
	SFX_die = NewSource("assets/die.wav", "static")
	SFX_gem = NewSource("assets/gem.wav", "static")
	SFX_ok = NewSource("assets/ok.wav", "static")
	SFX_cross = NewSource("assets/cross.wav", "static")
	SFX_revive = NewSource("assets/revive.wav", "static")
	SFX_powerup = NewSource("assets/powerup.wav", "static")
	SFX_punch = NewSource("assets/punch.wav", "static")

	FNT_points = love.graphics.newImageFont("assets/points.png", "0123456789")
	FNT_letters = love.graphics.newImageFont("assets/letters.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789.!?")

	BGM = BGM_bgm
	BGM:setLooping(true)

	table.insert(ENTITIES, NewTitle({}))
end

function love.update(dt)
	for i=1, #ENTITIES do
		if ENTITIES[i] and ENTITIES[i].update then
			ENTITIES[i]:update(dt)
		end
	end

	for i=1, #EFFECTS do
		if EFFECTS[i] and EFFECTS[i].update then
			EFFECTS[i]:update(dt)
		end
	end

	DetectCollisions()
end

function love.draw()
	love.graphics.draw(IMG_bg, 0, 0)

	love.graphics.push()

	love.graphics.translate(-CAMERA.x, -CAMERA.y)

	for i=1, #SOLIDS do
		if SOLIDS[i].draw then
			SOLIDS[i]:draw()
		end
	end

	for i=1, #ENTITIES do
		if ENTITIES[i].draw then
			ENTITIES[i]:draw()
		end
	end

	for i=1, #EFFECTS do
		if EFFECTS[i].draw then
			EFFECTS[i]:draw()
		end
	end

	love.graphics.pop()
end

function love.reset()
	SOLIDS = {}
	ENTITIES = {}
	EFFECTS = {}
	PHASE = nil
	STAGE = 1
	CHAR1 = nil
	CHAR2 = nil
	BGM:stop()
	BGM = nil
	LAST_UID = 0
	POINTS = 0
	CAMERA = {
		x = 0,
		y = 0,
	}

	love.load()
end

function love.serializeSize()
	return 200000
end

function love.serialize(size)
    local state = {}

	state.MAP = table.deep_copy(MAP)
	state.CAMERA = CAMERA
	state.PHASE = PHASE
	state.STAGE = STAGE
	state.CHAR1 = nil
	state.CHAR2 = nil
	state.BGMplaying = BGM:isPlaying()
	state.BGMsamples = BGM:tell("samples")
	state.LAST_UID = LAST_UID
	state.POINTS = POINTS

	state.SOLIDS = {}
	for i=1, #SOLIDS do
		if SOLIDS[i].serialize then
			state.SOLIDS[i] = SOLIDS[i]:serialize()
		end
	end

	state.ENTITIES = {}
	for i=1, #ENTITIES do
		if ENTITIES[i].serialize then
			state.ENTITIES[i] = ENTITIES[i]:serialize()
		end
	end

	state.EFFECTS = {}
	for i=1, #EFFECTS do
		if EFFECTS[i].serialize then
			state.EFFECTS[i] = EFFECTS[i]:serialize()
		end
	end

    return Json.stringify(state)
end

function love.unserialize(data, size)
    if data == nil then return end

	SOLIDS = {}
	ENTITIES = {}
	EFFECTS = {}
	PHASE = nil
	STAGE = 1
	CHAR1 = nil
	CHAR2 = nil
	BGM:stop()
	LAST_UID = 0
	POINTS = 0
	CAMERA = {
		x = 0,
		y = 0,
	}

    local state = Json.parse(data)

	MAP = state.MAP
	CAMERA = state.CAMERA
	PHASE = state.PHASE
	STAGE = state.STAGE
	if state.BGMplaying then BGM:play() else BGM:stop() end
	BGM:seek(state.BGMsamples, "samples")
	LAST_UID = state.LAST_UID
	POINTS = state.POINTS

	for i=1, #state.SOLIDS do
		if state.SOLIDS[i].type == ENT_GROUND then
			SOLIDS[i] = NewGround(state.SOLIDS[i])
		elseif state.SOLIDS[i].type == ENT_DIRT then
			SOLIDS[i] = NewDirt({})
		elseif state.SOLIDS[i].type == ENT_STAR then
			SOLIDS[i] = NewStar({})
		elseif state.SOLIDS[i].type == ENT_POWERBLOCK then
			SOLIDS[i] = NewPowerblock({})
		end
		SOLIDS[i]:unserialize(state.SOLIDS[i])
	end

	for i=1, #state.ENTITIES do
		if state.ENTITIES[i].type == ENT_TITLE then
			ENTITIES[i] = NewTitle({})
		elseif state.ENTITIES[i].type == ENT_BIRD then
			ENTITIES[i] = NewBird({})
		elseif state.ENTITIES[i].type == ENT_CROCO then
			ENTITIES[i] = NewCroco({})
		elseif state.ENTITIES[i].type == ENT_MONEY then
			ENTITIES[i] = NewMoney({})
		elseif state.ENTITIES[i].type == ENT_POWERUP_FIREBALL then
			ENTITIES[i] = NewPowerupFireball({})
		elseif state.ENTITIES[i].type == ENT_FIREBALL then
			ENTITIES[i] = NewFireball({})
		elseif state.ENTITIES[i].type == ENT_PUNCH then
			ENTITIES[i] = NewPunch({})
		elseif state.ENTITIES[i].type == ENT_CHARACTER then
			if state.ENTITIES[i].pad == 1 then
				CHAR1 = NewCharacter({pad = 1})
				ENTITIES[i] = CHAR1
			elseif state.ENTITIES[i].pad == 2 then
				CHAR2 = NewCharacter({pad = 2})
				ENTITIES[i] = CHAR2
			end
		end
		ENTITIES[i]:unserialize(state.ENTITIES[i])
	end

	for i=1, #state.EFFECTS do
		if state.EFFECTS[i].type == ENT_NOTIF then
			EFFECTS[i] = NewNotif({y=0})
		elseif state.EFFECTS[i].type == ENT_DIRT_PART then
			EFFECTS[i] = NewDirtPart({})
		elseif state.EFFECTS[i].type == ENT_BIRD_PART then
			EFFECTS[i] = NewBirdPart({})
		end
		EFFECTS[i]:unserialize(state.EFFECTS[i])
	end
end

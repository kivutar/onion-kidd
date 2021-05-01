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

function love.conf(t)
	t.width  = SCREEN_WIDTH
	t.height = SCREEN_HEIGHT
end

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())

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
	IMG_turnip_ghost_left = love.graphics.newImage("assets/turnip_ghost_left.png")
	IMG_turnip_ghost_right = love.graphics.newImage("assets/turnip_ghost_right.png")

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
	IMG_croco_ghost_left = love.graphics.newImage("assets/croco_ghost_left.png")
	IMG_croco_ghost_right = love.graphics.newImage("assets/croco_ghost_right.png")

	IMG_bird_fly_left = love.graphics.newImage("assets/bird_fly_left.png")
	IMG_bird_fly_right = love.graphics.newImage("assets/bird_fly_right.png")
	IMG_bird_die_left = love.graphics.newImage("assets/bird_die_left.png")
	IMG_bird_die_right = love.graphics.newImage("assets/bird_die_right.png")

	BGM_bgm = newSource("assets/medallion.ogg", "stream")

	SFX_jump = newSource("assets/jump.wav", "static")
	SFX_explode = newSource("assets/explode.wav", "static")
	SFX_ko = newSource("assets/ko.wav", "static")
	SFX_fireball = newSource("assets/fireball.wav", "static")
	SFX_enemy_die = newSource("assets/enemy_die.wav", "static")
	SFX_dirt_die = newSource("assets/dirt_die.wav", "static")
	SFX_die = newSource("assets/die.wav", "static")
	SFX_gem = newSource("assets/gem.wav", "static")
	SFX_ok = newSource("assets/ok.wav", "static")
	SFX_cross = newSource("assets/cross.wav", "static")
	SFX_revive = newSource("assets/revive.wav", "static")

	FNT_points = love.graphics.newImageFont("assets/points.png", "0123456789")
	FNT_letters = love.graphics.newImageFont("assets/letters.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789.!?")

	BGM = BGM_bgm
	BGM:setLooping(true)

	table.insert(ENTITIES, newTitle({}))
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

	detect_collisions()
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
	STATE = {}
	SOLIDS = {}
	ENTITIES = {}
	EFFECTS = {}
	PHASE = nil
	STAGE = 1
	CHAR1 = nil
	BGM = nil
	LAST_UID = 0
	CAMERA = {
		x = 0,
		y = 0,
	}

	love.load()
end

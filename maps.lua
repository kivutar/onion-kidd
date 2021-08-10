
function LoadMap(m)
	MAP = m

	for y = 1, #MAP, 1 do
		for x = 1, #MAP[y] do
			if MAP[y][x] == 1 then
				table.insert(SOLIDS, NewGround({uid=NewUID(),x=(x-1)*16,y=(y-1)*16}))
			elseif MAP[y][x] == 2 then
				table.insert(SOLIDS, NewDirt({uid=NewUID(),x=(x-1)*16,y=(y-1)*16}))
			elseif MAP[y][x] == 3 then
				table.insert(SOLIDS, NewStar({uid=NewUID(),x=(x-1)*16,y=(y-1)*16}))
			elseif MAP[y][x] == 4 then
				table.insert(ENTITIES, NewBird({uid=NewUID(),x=(x-1)*16,y=(y-1)*16}))
			elseif MAP[y][x] == 5 then
				table.insert(SOLIDS, NewPowerblock({uid=NewUID(),x=(x-1)*16,y=(y-1)*16}))
			elseif MAP[y][x] == 6 then
				table.insert(ENTITIES, NewPizza({uid=NewUID(),x=(x-1)*16,y=(y-1)*16}))
			end
		end
	end
end

function MapGet(y, x)
	if x < 0 or x > 20 then return nil end
	if y < 0 or y > #MAP then return nil end
	return MAP[y][x]
end

MAP_1 = {
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2},
	{1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,3,0,0,1,1},
	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,3,0,0,1,1},
	{1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,1,1},
	{1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,0,0,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,1,1},
	{1,1,3,0,0,0,0,0,0,0,0,0,0,0,2,2,0,0,1,1},
	{1,1,5,0,0,0,0,0,0,0,0,4,0,0,2,2,0,0,1,1},
	{1,1,1,1,1,0,0,1,1,1,1,1,0,0,1,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,3,3,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,3,2,1,1,1},
	{1,1,1,1,0,0,4,0,0,0,0,0,0,0,0,2,3,1,1,1},
	{1,1,1,1,0,2,0,2,0,3,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,1,0,2,0,3,0,2,0,0,0,0,1,1,1,1,1,1},
	{1,1,1,1,0,3,0,3,0,2,0,0,0,0,1,1,1,1,1,1},
	{1,1,1,1,0,1,1,1,0,1,1,1,0,0,0,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
	{1,3,3,2,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,3,3,2,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,3,3,2,0,0,2,2,2,3,3,2,2,2,0,0,0,1,1,1},
	{1,1,1,1,0,0,3,0,0,0,0,0,0,2,0,0,0,1,1,1},
	{1,1,1,0,0,0,2,0,0,0,4,0,0,3,0,0,0,1,1,1},
	{1,1,1,0,0,0,2,0,0,0,0,0,0,3,0,0,0,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,1,0,0,0,0,0,0,0,0,3,0,0,0,4,0,1,1,1},
	{1,1,1,2,2,2,2,0,0,0,0,2,0,0,0,0,0,1,1,1},
	{1,1,3,0,0,0,2,0,0,1,1,1,1,0,1,1,1,1,1,1},
	{1,1,3,0,0,0,2,0,0,0,1,1,0,0,0,1,1,1,1,1},
	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,3,3,1,1},
	{1,1,1,1,1,0,0,0,1,1,4,0,0,0,0,0,3,3,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,1,1},
	{1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1},
	{1,1,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,1,1,1,1,0,0,0,0,0,0,0,0,3,2,2,3,1,1},
	{1,1,1,1,1,1,2,0,0,0,0,0,0,0,2,0,0,0,1,1},
	{1,1,1,1,1,1,3,2,0,0,0,4,0,0,2,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,0,0,0,0,2,0,0,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,0,0,0,0,2,0,0,0,0,1,1,1},
	{1,1,0,0,2,3,3,2,0,0,4,0,2,0,0,0,0,0,1,1},
	{1,1,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1},
	{1,1,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1},
	{1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,2,0,0,0,0,0,2,2,5,1,1,1},
	{1,1,0,0,0,0,0,0,2,0,0,4,0,0,2,3,3,1,1,1},
	{1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1},
	{1,1,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1},
	{1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,3,0,0,0,0,0,0,0,3,0,0,0,4,0,0,1,1},
	{1,1,0,2,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1},
	{1,1,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1},
	{1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,0,1,1,1,1},
	{1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,0,1,1,1,1},
	{1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,0,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,1,1},
	{1,1,0,0,0,0,2,2,2,0,0,0,0,2,3,0,0,0,1,1},
	{1,1,0,0,0,1,1,1,1,2,0,0,0,3,2,0,0,0,1,1},
	{1,1,0,6,0,1,1,1,1,1,0,0,0,2,3,0,0,0,1,1},
	{1,1,0,0,0,1,1,1,1,1,0,0,0,2,3,0,0,0,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
}

MAP_demo = {
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0},
	{1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,1,1,3,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1},
	{1,1,1,3,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1},
	{1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,2,3,1,1},
	{1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,2,0,0,1,1,1,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,2,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,1,0,0,1,1,1,1,0,0,0,0,1,1,1,1,1,1},
	{1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,1,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,1,0,0,0,0,0,4,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,1,1,1},
	{1,1,0,0,0,0,0,0,0,2,1,1,1,1,1,0,3,1,1,1},
	{1,3,0,0,0,0,0,0,0,2,0,1,1,1,2,0,0,1,1,1},
	{1,2,2,0,0,0,0,0,0,0,0,0,0,0,0,2,0,1,1,1},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,1},
	{1,1,1,1,1,1,1,1,1,0,0,4,0,3,0,0,0,1,1,1},
	{1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1},
	{1,1,1,3,2,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,2,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1},
	{1,1,1,0,2,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
	{1,1,2,0,2,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,0,2,3,0,2,2,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,0,2,0,0,0,2,0,0,0,0,0,3,0,0,0,0,1,1,1},
	{1,0,3,0,4,0,3,3,1,1,1,1,1,0,0,0,0,1,1,1},
	{1,0,2,0,0,0,3,0,0,1,1,1,0,0,0,0,0,1,1,1},
	{1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,3,1,1},
	{1,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,2,2,1,1},
	{1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1},
	{1,2,2,2,2,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
	{1,3,0,0,2,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1},
	{1,3,0,0,2,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1},
	{1,3,0,0,2,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,2,1,1,1},
	{1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,2,0,1,1,1},
	{1,1,1,1,1,0,0,0,0,0,0,0,0,0,2,0,0,1,1,1},
	{1,1,1,1,0,0,0,4,0,0,1,1,1,1,1,0,0,1,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1},
	{1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,0,3,1,1,1},
	{1,1,0,0,0,0,1,1,1,1,1,1,1,1,0,0,3,1,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,2,2,3,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,0,0,0,2,0,0,0,0,0,0,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,2,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1},
	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1},
	{1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,2,1,1},
	{1,1,3,2,0,0,0,0,0,0,0,0,0,0,0,0,2,0,1,1},
	{1,1,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,1,1,0,0,0,0,0,0,4,0,0,0,0,3,3,3,1,1},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2,1,1},
	{1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,0,0,0,0,0,3,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1},
	{1,1,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,1,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,1,1},
	{1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,1,1},
	{1,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1},
}

STAGES = {
	--MAP_demo,
	MAP_1,
}

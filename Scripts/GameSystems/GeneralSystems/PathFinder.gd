extends Node2D

@onready var grid_manager: Node2D = %GridManager

var directions: Array[Vector2i] = [
Vector2i(0, -1),
Vector2i(1, -1),
Vector2i(1, 0), 
Vector2i(0, 1), 
Vector2i(-1, 1),
Vector2i(-1, 0), 
]

# stores the previous node on the shortest path for each node  
var prev = {}

# stores the distnace of each node from the current position 
var distance = {}

# Store tiles in range of currently selected unit
var new_tiles_in_range


func oddr_to_axial(hex: Vector2i):
	var q = hex.x - (hex.y - (hex.y & 1)) /2 
	var r = hex.y
	return Vector2i(q,r)

func axial_to_oddr(hex: Vector2i) -> Vector2i:
	var col = hex.x + (hex.y - (hex.y & 1)) / 2
	var row = hex.y
	return Vector2i(col, row)


# check which tiles are immediatley avaialbe
func neighbours(player_controller : PlayerController,  current_position:Vector2i, mapping_to_check = null ) -> Array[Vector2i]:  
	var possible_directions: Array[Vector2i] = []
	for direction in directions: 
		var new_dir = direction + current_position
		if mapping_to_check != null:
			if grid_manager.check_bounds(axial_to_oddr(new_dir)) and !mapping_to_check.has(axial_to_oddr(new_dir)):
					possible_directions.append(new_dir)
		else: 
			if grid_manager.check_bounds(axial_to_oddr(new_dir)): 
				possible_directions.append(new_dir)
	return possible_directions

# Dijkstra's algorithm to find the shortest path to all tiles (from a given)
func shortest_path_to_all_tiles(player_controller : PlayerController,  start, cost_func: Callable, mapping_to_check = null):
	var visited = []
	var queue := [ { "pos": start, "cost": 0 } ]


	# For every tile we set it too infinite, should change maybe?
	for tile in grid_manager.terrain_grid:
		distance[oddr_to_axial(tile)] = INF

	distance[start] = 0  

	while queue.size() > 0:
		# sort queue by cost
		queue.sort_custom(func(a, b): return a["cost"] < b["cost"])
		var current = queue.pop_front()
		
		var current_pos = current["pos"]
		var current_cost : int = current["cost"]
		#print(distance)
		visited.append(current_pos)
		
		for v in neighbours(player_controller,current_pos, mapping_to_check):
			# Get terrain cost
			#var terrain_cost = (grid_manager.terrain_grid.get(axial_to_oddr(v))).movement_cost
			
			var cost = cost_func.call(player_controller,axial_to_oddr(v))
			
			# check if current distance of the neighbour is greater than new cost (terrain + current_node)
			if distance[v] > cost + current_cost and v not in visited:
				# update the neighbour cost with better travel cost 
				distance[v] = cost + current_cost
				
				#update previous node of neighbour to be current
				prev[v] = current_pos
				queue.append({ "pos": v, "cost": distance[v] } )

# Given the shortest path, find the tiles in range for a given number of moves
func find_in_range(number_of_moves):
	var tiles_in_range = []
	for key in distance.keys():
		var value = distance[key]
		if value <= number_of_moves:
			tiles_in_range.append(key)
		
	return tiles_in_range

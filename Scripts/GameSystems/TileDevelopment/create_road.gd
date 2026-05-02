extends Node
@onready var path_finder: Node2D = %PathFinder

@onready var road_ui: Node2D = %road_direction
@onready var grid_manager: Node2D = %GridManager

@onready var tile_developement_manager: Node2D = $"../../../../DataManagers/TileDevelopementManager"

@onready var build_td: Node2D = $"../../build_td"

func path_finder_road_cost(player_controller : PlayerController, pos : Vector2i ) -> int: 
	if grid_manager.terrain_grid.get(pos).name == "water":
		return 1000 
	elif player_controller.tile_developement_manager.road_list.has(pos):
		return 1
	else: 
		return 2

func create_road_path(player_controller : PlayerController, start_pos : Vector2i, target_pos : Vector2i ):

	target_pos = path_finder.oddr_to_axial(target_pos)
	start_pos = path_finder.oddr_to_axial(start_pos)
	
	# call path finder to calculate shortest path to all nodes, passing in a constant instead of terrain cost and tile_development map instead of unit map
	
	path_finder.shortest_path_to_all_tiles(player_controller,start_pos,path_finder_road_cost )
	# Then caluclate path from target to start 
	var current_pos = path_finder.prev[target_pos]
	var path : Array[Vector2i] = [current_pos]
	while current_pos != start_pos:
			current_pos = path_finder.prev.get(current_pos)
			path.append(current_pos)
	path.push_front(target_pos)
	
	
	
	var path_oddr = path.map(func(x): return path_finder.axial_to_oddr(x))
	var tile_map_coords = road_ui.create_road_display(path_oddr)
	
	# create a mapping for path -> TileMap coords
	
	build_td.build_road(player_controller, path_oddr, tile_map_coords)
	
	player_controller.player_data.build_obj = null



# How to add intersections and ensure that road path finding uses exisitng roads 
# 
# TO ensure that road path finding uses exisitng roads 
# 	path finding prioritises roads 
# 	When building roads, we dont want to build over exisitng roads, so we should create a new path array for roads to buil
#	This is path minus positions that already contain roads
# 	
# 
# 	# When deciding which road sprite 
#		We have 6 tile maps to model the maximum of a 6 direction intersection then 6 sprites for each direction 
#		Choosing which sprite is based off the prev and current and current and next 
# 		the first two tile maps are for the standard roads without intersections (road level 2) 
# 		
 
	# remove parts of path that belong to a road
#

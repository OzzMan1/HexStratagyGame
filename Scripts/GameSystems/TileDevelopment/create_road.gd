extends Node
@onready var path_finder: Node2D = %PathFinder

@onready var road_ui: Node2D = %road_display
@onready var grid_manager: Node2D = %GridManager

@onready var tile_developement_manager: Node2D = $"../../../../DataManagers/TileDevelopementManager"

@onready var build_td: Node2D = $"../../build_td"

func path_finder_road_cost(pos : Vector2i ) -> int: 
	if grid_manager.terrain_grid.get(pos).name == "water":
		return 1000 
	else:
		return 1

func create_road_path(player_controller : PlayerController, start_pos : Vector2i, target_pos : Vector2i ):

	target_pos = path_finder.oddr_to_axial(target_pos)
	start_pos = path_finder.oddr_to_axial(start_pos)
	
	# call path finder to calculate shortest path to all nodes, passing in a constant instead of terrain cost and tile_development map instead of unit map
	
	path_finder.shortest_path_to_all_tiles(player_controller,start_pos,path_finder_road_cost,tile_developement_manager.tile_development_list )
	# Then caluclate path from target to start 
	var current_pos = path_finder.prev[target_pos]
	var path : Array[Vector2i] = [current_pos]
	while current_pos != start_pos:
			current_pos = path_finder.prev.get(current_pos)
			path.append(current_pos)
	path.push_front(target_pos)
	
	
	
	var path_oddr = path.map(func(x): return path_finder.axial_to_oddr(x))
	var tile_map_coords = road_ui.create_road_display(path_oddr)
	
	build_td.build_road(player_controller, path_oddr, tile_map_coords)
	

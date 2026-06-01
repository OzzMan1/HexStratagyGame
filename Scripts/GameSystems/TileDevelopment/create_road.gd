extends Node
@onready var path_finder = get_tree().current_scene.find_child("PathFinder", true, false)

@onready var road_ui: Node2D = %road_direction
@onready var grid_manager: Node2D = get_tree().current_scene.find_child("GridManager", true, false)

@onready var tile_developement_manager: Node2D = %TileDevelopementManager


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
	
	var prev = 	path_finder.shortest_path_to_all_tiles(player_controller,start_pos,path_finder_road_cost)[0]
	# Then caluclate path from target to start 
	var current_pos = prev[target_pos]
	var path : Array[Vector2i] = [current_pos]
	while current_pos != start_pos:
			current_pos = prev.get(current_pos)
			path.append(current_pos)
	path.push_front(target_pos)
	
	
	
	
	# [Vector2i]
	var path_oddr = path.map(func(x): return path_finder.axial_to_oddr(x))
	# [Vector2i]
	var tile_map_coords = road_ui.create_road_display(path_oddr)
	
	return [path_oddr, tile_map_coords]

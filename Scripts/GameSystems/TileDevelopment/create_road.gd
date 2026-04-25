extends Node
@onready var path_finder: Node2D = %PathFinder

@onready var road_ui: Node2D = %RoadUI

func create_road_path(player_controller : PlayerController, start_pos : Vector2i, target_pos : Vector2i ):

	target_pos = path_finder.oddr_to_axial(target_pos)
	start_pos = path_finder.oddr_to_axial(start_pos)
	
	# call path finder to calculate shortest path to all nodes
	path_finder.shortest_path_to_all_tiles(player_controller,start_pos)
	# Then caluclate path from target to start 
	var current_pos = path_finder.prev[target_pos]
	var path : Array[Vector2i] = [current_pos]
	while current_pos != start_pos:
			current_pos = path_finder.prev.get(current_pos)
			path.append(current_pos)
	path.push_front(target_pos)
	
	var path_oddr = path.map(func(x): return path_finder.axial_to_oddr(x))
	road_ui.create_road_display(path_oddr)
	player_controller.player_data.build_obj = null
	



	#path_finder.new_tiles_in_range = path_finder.find_in_range()
	#var tiles_in_range_offset = path_finder.new_tiles_in_range.map(func(x): return path_finder.axial_to_oddr(x))
	
	
	
		
# Then check how much of the path we can afford

#

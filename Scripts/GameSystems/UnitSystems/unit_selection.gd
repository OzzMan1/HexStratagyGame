extends Node
 
# We select unit 
# it shows movement range
# We then right click the destination 
# 

func select_unit(player_controller : PlayerController, pos : Vector2i):	
	#Get reference to unit at pos 
	var current_selected_unit = player_controller.player_data.target_to_unit.get(pos)
	
	var axial_pos = player_controller.path_finder.oddr_to_axial(pos)
	var results = player_controller.path_finder.shortest_path_to_all_tiles(player_controller,axial_pos,player_controller.unit_movement.cost_function)
	var prev = results[0]
	var distance = results[1]
	
	
	var new_tiles_in_range = player_controller.path_finder.find_in_range(current_selected_unit.current_num_of_moves, distance)
	current_selected_unit.prev_list = prev 
	current_selected_unit.tiles_in_range = new_tiles_in_range
	
	var tiles_in_range_offset = new_tiles_in_range.map(func(x): return player_controller.path_finder.axial_to_oddr(x))
	player_controller.overlay_map.select_unit(tiles_in_range_offset)

	

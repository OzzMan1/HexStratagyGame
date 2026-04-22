extends Node2D

@onready var path_finder: Node2D = %PathFinder
@onready var unit_movemement_overlay = %UnitMovementOverlay

var current_selected_unit : Unit 



# click, get first object
# click again, get second object

#

var objects_at_pos = []


func get_objects_at_pos(player_controller : PlayerController, objects_at_pos, clicked_pos : Vector2i):

	var target_to_unit = player_controller.player_data.target_to_unit
	if target_to_unit.has(clicked_pos):
		objects_at_pos.append(target_to_unit.get(clicked_pos))
	

	if player_controller.grid_manager.re_grid.has(clicked_pos):
		if player_controller.grid_manager.re_grid[clicked_pos].resource_improvment_type == "iron":
			objects_at_pos.append(player_controller.grid_manager.re_grid[clicked_pos].resource_improvment_type)
	
	
# [unit, iron]
func get_clicked_object(player_controller : PlayerController, clicked_pos : Vector2i): 
	# if the user has clicked this position before then we remove the last clicked item 
	get_objects_at_pos(player_controller,objects_at_pos,clicked_pos)  
	print(objects_at_pos)
	if player_controller.player_data.last_clicked_pos == clicked_pos:
		objects_at_pos.pop_front() 
		print(objects_at_pos.front())
		return objects_at_pos.front()
	else:		
		return objects_at_pos.front()
	player_controller.player_data.last_clicked_pos = clicked_pos

		
	var target_to_unit = player_controller.player_data.target_to_unit
	if target_to_unit.has(clicked_pos):
		return target_to_unit.get(clicked_pos)
	return null




func select_unit(player_controller : PlayerController, pos : Vector2i):	
	#Get reference to unit at pos 
	current_selected_unit = player_controller.player_data.target_to_unit.get(pos)
	
	var axial_pos = path_finder.oddr_to_axial(pos)
	path_finder.shortest_path_to_all_tiles(player_controller,axial_pos)
	
	path_finder.new_tiles_in_range = path_finder.find_in_range(current_selected_unit.current_num_of_moves)
	var tiles_in_range_offset = path_finder.new_tiles_in_range.map(func(x): return path_finder.axial_to_oddr(x))
	

	unit_movemement_overlay.select_unit_overlay_update(tiles_in_range_offset)

	
	

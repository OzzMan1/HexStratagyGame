extends Node2D

@onready var path_finder: Node2D = %GameSystems/PathFinder
@onready var unit_movemement_overlay = %UnitMovementOverlay

var current_selected_unit : Unit 


func get_clicked_object(player_controller : PlayerController, pos : Vector2i): 
	var target_to_unit = player_controller.player_data.target_to_unit
	if target_to_unit.has(pos):
		return target_to_unit.get(pos)
	return null


func select_unit(player_controller : PlayerController, pos : Vector2i):	
	#Get reference to unit at pos 
	current_selected_unit = player_controller.player_data.target_to_unit.get(pos)
	
	var axial_pos = path_finder.oddr_to_axial(pos)
	path_finder.shortest_path_to_all_tiles(player_controller,axial_pos)
	
	path_finder.new_tiles_in_range = path_finder.find_in_range(current_selected_unit.current_num_of_moves)
	var tiles_in_range_offset = path_finder.new_tiles_in_range.map(func(x): return path_finder.axial_to_oddr(x))
	

	unit_movemement_overlay.select_unit_overlay_update(tiles_in_range_offset)

	
	

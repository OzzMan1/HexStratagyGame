extends Node

@onready var grid_manager: Node2D = get_tree().current_scene.find_child("GridManager", true, false)



func create_new_unit(player_controller,position):
	var new_unit = player_controller.player_data.get_archer_scene().instantiate()
	update_unit_position(player_controller,new_unit,position)
	update_unit_list(player_controller, new_unit, position)
	add_child(new_unit)
	
func update_unit_position(player_controller,unit : Unit, new_pos : Vector2i):
	unit.position = player_controller.grid_manager.get_world_pos(new_pos)
	unit.tile_pos = new_pos 
func update_unit_list(player_controller,unit, target, prev = null):
	# update players unit list
	# Update global unit list
	if prev != null:
		player_controller.player_data.target_to_unit.erase(prev)
		player_controller.grid_manager.unit_list.erase(prev)
	player_controller.player_data.target_to_unit[target] = unit
	player_controller.grid_manager.unit_list[target] = unit 

func update_unit_movement(unit_list : Dictionary):
	for unit in unit_list.values():
		unit.current_num_of_moves = unit.number_of_moves

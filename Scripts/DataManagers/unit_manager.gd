extends Node



# Type is: Vector2i -> ("player_name" : String, "Unit" : Unit )
var unit_list : Dictionary

@onready var grid_manager: Node2D = get_tree().current_scene.find_child("GridManager", true, false)


# Create new unit (player_name, position)

func _ready() -> void:
	EventBus.unit_built.connect(create_new_unit)
	EventBus.unit_moved.connect(move_unit)

func move_unit(player_name, unit, prev, target):
	update_unit_position(unit, target)
	update_unit_list(player_name, unit, target, prev) 

func create_new_unit(player_name,player_index,build_pos, ):
	var new_unit = get_unit(player_index).instantiate()
	
	update_unit_position(new_unit,build_pos)
	update_unit_list(player_name, new_unit, build_pos)
	add_child(new_unit)

func get_unit(player_index: int): 
	match player_index:
		1: 
			return Register.unit_1
		2:
			return Register.unit_2

func update_unit_position(unit : Unit, new_pos : Vector2i):
	unit.position = grid_manager.get_world_pos(new_pos)
	unit.tile_pos = new_pos 

func update_unit_list(player_name,unit, target, prev = null):
	# remove the unit from its previous position
	if prev != null:
		unit_list[prev].erase()
	# Update the list with the units new position
	unit_list[target]= {"player_name" : player_name, "Unit" : unit}
	

func update_unit_movement(unit_list : Dictionary):
	for unit in unit_list.values():
		unit.current_num_of_moves = unit.number_of_moves

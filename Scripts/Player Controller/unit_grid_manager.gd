extends Node

var unit_list_local = {}
@onready var grid_manager: Node2D = %GridManager
@onready var player_controller: Node2D = %PlayerController

func update_unit_list_local(unit : Unit, target: Vector2i, previous_pos : Variant = null):		
		# assign it to the unit grid
		unit_list_local.set(target,unit)
		# erase the value at the previous position
		if unit_list_local.has(previous_pos):
			unit_list_local.erase(previous_pos)
		 
		# move units position 
		unit.position = grid_manager.get_world_pos(target)
		unit.tile_pos = target 

func spawn_unit_test(mouse_pos):
	
	var tile_pos = grid_manager.get_tile_pos(mouse_pos)
	# Check if Unit is there, if not then we can spawn a new unit and add it as a child
	if !unit_list_local.has(tile_pos):
		var new_unit = player_controller.return_archer_scene().instantiate()
		update_unit_list_local(new_unit,tile_pos)	
		#print("Grid manager spwan unit test: ", unit_list_local)
		new_unit.position = grid_manager.get_world_pos(tile_pos)
		new_unit.tile_pos = tile_pos 
		add_child(new_unit)
	elif unit_list_local.has(tile_pos): 
		print("Cant build here, there is unit: ", unit_list_local.get(tile_pos).name)

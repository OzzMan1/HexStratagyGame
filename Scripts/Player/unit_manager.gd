extends Node

@onready var grid_manager: Node2D = %GridManager



func update_unit_list_local(player_controller: PlayerController, unit : Unit, target: Vector2i, previous_pos : Variant = null):		
		
		
		var unit_list_local = player_controller.player_data.get_unit_list_local()
		# assign it to the unit grid
		unit_list_local.set(target,unit)
		# erase the value at the previous position
		if unit_list_local.has(previous_pos):
			unit_list_local.erase(previous_pos)
		 
		# move units position 
		unit.position = grid_manager.get_world_pos(target)
		unit.tile_pos = target 

func spawn_unit_test(player_controller: PlayerController, mouse_pos):
	
	var tile_pos = grid_manager.get_tile_pos(mouse_pos)
	var unit_list_local = player_controller.player_data.get_unit_list_local()
	# Check if Unit is there, if not then we can spawn a new unit and add it as a child
	if !unit_list_local.has(tile_pos):
		var new_unit = player_controller.player_data.get_archer_scene().instantiate()
		update_unit_list_local(player_controller,new_unit,tile_pos)	
		#print("Grid manager spwan unit test: ", unit_list_local)
		new_unit.position = grid_manager.get_world_pos(tile_pos)
		new_unit.tile_pos = tile_pos 
		add_child(new_unit)
	elif unit_list_local.has(tile_pos): 
		print("Cant build here, there is unit: ", unit_list_local.get(tile_pos).name)

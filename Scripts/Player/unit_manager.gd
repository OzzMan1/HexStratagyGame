extends Node

@onready var grid_manager: Node2D = %GridManager



func update_unit_list_local(player_controller: PlayerController, unit : Unit, new_unit_order : unit_order):		
		
		
		# Update unit data  
		
		# add order to list of orders
		player_controller.player_data.local_unit_orders.append(new_unit_order)
		# Add unit order
		if player_controller.player_data.unit_order_stack.has(unit):
			player_controller.player_data.unit_order_stack[unit].append(new_unit_order)
		else:
			player_controller.player_data.unit_order_stack[unit] = [new_unit_order]			
		# update the target mapping
		if player_controller.player_data.target_to_unit.has(new_unit_order.prev):
			player_controller.player_data.target_to_unit.erase(new_unit_order.prev)
		player_controller.player_data.target_to_unit.set(new_unit_order.target,unit)
		
		# move units position 
		unit.position = grid_manager.get_world_pos(new_unit_order.target)
		unit.tile_pos = new_unit_order.target 

func spawn_unit_test(player_controller: PlayerController, mouse_pos):
	
	var tile_pos = grid_manager.get_tile_pos(mouse_pos)
	var target_to_unit = player_controller.player_data.target_to_unit

	# Check if Unit is there, if not then we can spawn a new unit and add it as a child
	if !target_to_unit.has(tile_pos):
		var new_unit = player_controller.player_data.get_archer_scene().instantiate()
		var new_unit_order = unit_order.new(tile_pos,tile_pos,new_unit,0)
		
		update_unit_list_local(player_controller,new_unit,new_unit_order)	
		# Add unit as an object
		new_unit.position = grid_manager.get_world_pos(tile_pos)
		new_unit.tile_pos = tile_pos 
		add_child(new_unit)
	elif target_to_unit.has(tile_pos): 
		print("Cant build here, there is unit: ")

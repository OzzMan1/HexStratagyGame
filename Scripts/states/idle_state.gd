extends State

class_name IdleState



func handle_input(player_controller, event) -> void:
	if event.is_action_pressed("click"):

		var pos = player_controller.return_mouse_pos()
		var clicked = player_controller.unit_selection.get_clicked_object(player_controller,pos)
	
		if clicked != null:
			player_controller.set_state(SelectState.new(pos, clicked))
		
		# if Tile 
			# enter select state
		
		else:
			player_controller.unit_grid_manager.spawn_unit_test(player_controller.get_local_mouse_position())
	if event.is_action_pressed("space"):
		player_controller.unit_movement.display_unit_orders()
	elif event.is_action_released("space"):
		player_controller.unit_movemement_overlay.clear_overlay_maps()
	elif event.is_action_pressed("enter"):
		player_controller.unit_movement.implement_move_orders()	
	
	#elif event.is_action_pressed("EndTurnTemp"):
			#player_controller.end_turn_request()

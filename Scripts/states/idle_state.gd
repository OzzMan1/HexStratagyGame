extends State

class_name IdleState



func handle_input(player_controller, event) -> void:
	if event.is_action_pressed("click"):

		var pos = player_controller.return_mouse_pos()
		var clicked = player_controller.unit_selection.get_clicked_object(player_controller,pos)
	
		if clicked != null:
			player_controller.set_state(SelectState.new(pos, clicked))
		else:
			player_controller.unit_manager.spawn_unit_test(player_controller,player_controller.get_local_mouse_position())


	#elif event.is_action_pressed("EndTurnTemp"):
			#player_controller.end_turn_request()

extends State

class_name IdleState

var state_name : String = "Idle"





func handle_input(player_controller, event) -> void:
	if event.is_action_pressed("click"):

		var pos = player_controller.return_mouse_pos()
		var clicked = player_controller.selection_system.get_clicked_object(player_controller,pos)
		if clicked != null:
			player_controller.set_state(SelectState.new(pos, clicked))

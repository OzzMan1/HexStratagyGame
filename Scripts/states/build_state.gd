extends State

class_name BuildState


var build_obj : Buildable

#
#func _init(_build_obj : Buildable):
	#build_obj = _build_obj



func handle_input(player_controller, event) -> void:
	
	build_obj = player_controller.player_data.build_obj
	if event.is_action_pressed("click") and build_obj != null:
		# if player build obj is not null	
		
		if build_obj is Road: 
			player_controller.set_state(SelectState.new(player_controller.return_mouse_pos(),build_obj))
		
		if build_obj is TileDevelopment:
			var pos = player_controller.return_mouse_pos()
			var clicked = player_controller.selection_system.get_clicked_object(player_controller,pos)
			player_controller.build_td.build_td(player_controller,clicked,build_obj,pos)
			
	elif event.is_action_pressed("b"):
		player_controller.set_state(IdleState.new())

func enter(player_controller) -> void:
	player_controller.build_td_menu.visible = true
	player_controller.build_td_menu.player_controller = player_controller

	
func exit(player_controller) -> void:
	# cancel_overlay() 
	player_controller.build_td_menu.toggle_of_all_buttons_except()
	player_controller.build_td_menu.visible = false
	player_controller.overlay_map.clear_overlay_maps()
	pass

	

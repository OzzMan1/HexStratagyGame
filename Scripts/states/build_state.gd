extends State

# This state handles player input when building something

class_name BuildState


var build_obj : Buildable

var state_name : String = "Build"


func handle_input(player_controller, event) -> void:
	
	build_obj = player_controller.player_data.build_obj
	if event.is_action_pressed("click") and build_obj != null:
		# if player build obj is not null			
		# Make this for obj 
		var pos = player_controller.return_mouse_pos()
		if player_controller.grid_manager.check_bounds(pos):
			build_obj._on_build(player_controller, pos)
			


func enter(player_controller) -> void:
	# pass in the menu 
	player_controller.player_data.current_menu.visible = true

	
func exit(player_controller) -> void:
	# cancel_overlay() 
	# deal with late	
	if player_controller.player_data.current_menu.has_method("toggle_of_all_buttons_except"):	
		player_controller.player_data.current_menu.toggle_of_all_buttons_except()
	player_controller.player_data.current_menu.visible = false
	player_controller.overlay_ui.clear_overlay_maps(player_controller)
	

	

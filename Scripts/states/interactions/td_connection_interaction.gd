extends Interaction

class_name td_connection_interaction

# change good, click button -> new list opens 
# can search and select good
# press escape to close it

func enter(player_controller) -> void:
	player_controller.select_td_menu.visible = true 
	player_controller.td_connections.get_all_possible_td_connections(player_controller)
	
func exit(player_controller) -> void:
	player_controller.player_data.selected_td = null
	player_controller.player_data.selected_td_pos = Vector2i(10000,100000)
	player_controller.select_td.deselect_TD(player_controller)
	
		
func handle_input(player_controller, event,pos) -> void:
	player_controller.td_connections.add_td_connection(player_controller,pos)
	

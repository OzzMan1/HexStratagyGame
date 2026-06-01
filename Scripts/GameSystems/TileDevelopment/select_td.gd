extends Node

func select_TD(player_controller : PlayerController,pos, td_obj : TileDevelopment):
	if player_controller.check_td_belongs_to_player(pos):
		player_controller.player_data.selected_td = td_obj
		player_controller.player_data.selected_td_pos = pos
		player_controller.select_td_menu.set_up_menu(td_obj)
		player_controller.select_td_menu.visible = true 
		player_controller.select_td_menu.toggle_connection_button()

		if td_obj.has_method("update_ui"):
			td_obj.update_ui(player_controller.select_td_menu)


func deselect_TD(player_controller : PlayerController):
	player_controller.select_td_menu.visible = false 
	player_controller.change_good_menu.visible = false
	player_controller.overlay_ui.clear_overlay_maps(player_controller)

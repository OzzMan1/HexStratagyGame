extends Buildable

class_name  TileDevelopment

func on_select(player_controller,selected_pos):
	player_controller.select_td.select_TD(player_controller,selected_pos,self)

func deselect(player_controller):
	player_controller.select_td.deselect_TD(player_controller)

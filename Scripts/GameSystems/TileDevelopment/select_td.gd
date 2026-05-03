extends Node

@onready var select_td_menu: VBoxContainer = %SelectTDMenu



func select_industiral(player_controller : PlayerController,pos ,industrial_obj : Industrial):
	if player_controller.check_td_belongs_to_player(pos):
		select_td_menu.player_controller = player_controller
		player_controller.player_data.selected_td = industrial_obj
		player_controller.player_data.selected_td_pos = pos
		select_td_menu.update_good_produced_ui(industrial_obj.good_produced,industrial_obj.number_of_processed_goods_produced)
		player_controller.select_td_menu.visible = true 
	

func deselect_industiral(player_controller : PlayerController):
	player_controller.select_td_menu.visible = false 

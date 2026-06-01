extends TileDevelopment

class_name  City
var range = 4

var player

# incoming goods 
var td_type : String = "City"



func set_up_select_menu(menu):
	menu.change_good_button.visible = false 
	menu.good_produced_label.visible = false 			 
	menu.expand_td_button.visible = false
	menu.good_produced_label.visible = false 
	menu.td_connection_button.visible = false 
	menu.td_connection.visible = false

func add_goods_to_stockpile():
	print("incoming goods ", incoming_goods)
	for good in incoming_goods:
		if player.player_data.resources_amount.has(good):
			player.player_data.resources_amount[good] += incoming_goods[good]
		else:
			player.player_data.resources_amount[good] = incoming_goods[good]

	
	print("player.player_data.resources_amount ", player.player_data.resources_amount )
	incoming_goods.clear()
	

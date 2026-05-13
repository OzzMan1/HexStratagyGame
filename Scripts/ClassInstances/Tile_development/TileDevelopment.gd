extends Buildable

class_name  TileDevelopment

var incoming_goods : Dictionary = {}
var good_stockpile : Dictionary = {}
var unsent_goods : Dictionary = {}
# Not for resource extraction 
var incoming_td_connections : Dictionary[Vector2i, TileDevelopment]
#TD information
# who are you sending goods to
var td_connections : Dictionary[Vector2i, TileDevelopment]
var possible_td_connections  : Dictionary[Vector2i,TileDevelopment]




func on_select(player_controller,selected_pos):
	player_controller.select_td.select_TD(player_controller,selected_pos,self)

func deselect(player_controller):
	player_controller.select_td.deselect_TD(player_controller)


func add_goods_to_stockpile():
	for good in incoming_goods:
		if good_stockpile.has(good):
			good_stockpile[good] += incoming_goods[good]
		else: 
			good_stockpile[good] = incoming_goods[good]
	for good in unsent_goods:
		if good_stockpile.has(good):
			good_stockpile[good] += unsent_goods[good]
		else: 
			good_stockpile[good] = unsent_goods[good]
	unsent_goods.clear()
	incoming_goods.clear()

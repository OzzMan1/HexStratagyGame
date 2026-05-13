extends TileDevelopment

class_name  City
var range = 4

var player

# incoming goods 
var td_type : String = "City"



func add_goods_to_stockpile():
	print("incoming goods ", incoming_goods)
	for good in incoming_goods:
		if player.player_data.resources_amount.has(good):
			player.player_data.resources_amount[good] += incoming_goods[good]
		else:
			player.player_data.resources_amount[good] = incoming_goods[good]

	
	print("player.player_data.resources_amount ", player.player_data.resources_amount )
	incoming_goods.clear()
	

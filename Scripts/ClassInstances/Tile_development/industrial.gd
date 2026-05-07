extends TileDevelopment


class_name Industrial 

var td_type : String = "industrial"

#TD information
var td_connections : Dictionary[Vector2i, TileDevelopment]
var possible_td_connections  : Dictionary[Vector2i,TileDevelopment]
var range = 4


# job informaiton
var number_of_processed_goods_produced : int = 0
var good_produced : Good  
var number_of_goods_consumed : int = 0


func update_ui(menu):
	menu.update_good_produced_ui(
		good_produced,
		number_of_processed_goods_produced
	)

# what resources do you need to build
var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}



func _init() -> void:
	pass

extends TileDevelopment

class_name ResourceExtraction 

var number_of_raw_goods_produced : int 
var td_type : String = "resource extractor"


#TD information
var td_connections : Dictionary[Vector2i, TileDevelopment]
var possible_td_connections  : Dictionary[Vector2i,TileDevelopment]
var range = 4

# job informaiton
var number_of_good_produced : int = 0
var good_produced : Good  

func update_ui(menu):
	menu.update_good_produced_ui(
		good_produced,
		number_of_good_produced
	)
	
var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}
func _init() -> void:
	pass

extends TileDevelopment


class_name Industrial 

var td_type : String = "industrial"

var range = 4
#TD information
# who are you sending goods to
var td_connections : Dictionary[Vector2i, TileDevelopment]
var possible_td_connections  : Dictionary[Vector2i,TileDevelopment]

# Not for resource extraction 
var incoming_td_connections : Dictionary[Vector2i, TileDevelopment]

# job informaiton
var good_produced : Good  
var number_of_good_produced : int = 0



# Incoming goods 
var incoming_goods : Dictionary[Good, int]
var exported_goods : Dictionary[Good, int]
var good_stockpile : Dictionary[Good, int]



func update_ui(menu):
	menu.update_good_produced_ui(
		good_produced,
		number_of_good_produced
	)

# what resources do you need to build
var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}



func _init() -> void:
	pass

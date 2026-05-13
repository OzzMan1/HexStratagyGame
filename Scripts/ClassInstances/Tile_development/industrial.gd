extends TileDevelopment

class_name Industrial 

var td_type : String = "industrial"

var expansion_level : int = 1 
var range = 4


# job informaiton
var good_produced : Good  
var number_of_good_produced : int = 0


var capacity : int = 100 



# Incoming goods 




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

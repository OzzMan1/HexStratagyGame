extends Buildable

class_name Road 

var td_type : String = "road"

# what resources do you need to build

var resource_cost = {
	GoodsDatabase.stone: 10,
	GoodsDatabase.timber: 10,
}

func on_select(player_controller,selected_pos):
	# call overlay 
	print("eneterd select state")

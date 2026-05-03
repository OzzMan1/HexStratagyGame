extends TileDevelopment


class_name Industrial 

var td_type : String = "industrial"

#TD information
var td_connections 
var range = 4


# job informaiton
var number_of_processed_goods_produced : int = 0
var good_produced : Good  
var number_of_goods_consumed : int = 0




func on_select(player_controller,selected_pos):
	player_controller.select_td.select_industiral(player_controller,selected_pos,self)

func deselect(player_controller):
	player_controller.select_td.deselect_industiral(player_controller)

# what resources do you need to build
var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}


# for different values it needs to store integers 


	


func _init() -> void:
	pass

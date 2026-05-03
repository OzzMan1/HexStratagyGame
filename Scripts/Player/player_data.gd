extends Node


# Unit info
var local_unit_orders : Array[unit_order]
var unit_order_stack : Dictionary[Unit,Array]
var target_to_unit : Dictionary[Vector2i, Unit]
@export var archer_scene: PackedScene


var has_ended_turn : bool = false
@export var player_name : String 

# For cycling objects
var last_clicked_pos : Vector2i
var last_clicked_index : int

# currnet build object 
var build_obj : Buildable

# Tile Developments 
var player_tile_to_TD : Dictionary[Vector2i, TileDevelopment] 
# selecting tile developments
var selected_td : TileDevelopment
var selected_td_pos : Vector2i





# resources
var resources_amount = {
	GoodsDatabase.stone : 500,
	GoodsDatabase.timber: 500,
}




func get_archer_scene():
	return 	archer_scene


func test():
	print(player_name)

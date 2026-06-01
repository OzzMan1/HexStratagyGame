extends Node

# This stores and manages the list of all Tile developments in the game 

# The Dictionary is type Vector2I -> ("name" : String) ("TD" : Tile Development)
var tile_development_list : Dictionary

var road_list : Dictionary[Vector2i,Road]

func _ready() -> void:
	EventBus.TDBuilt.connect(update_tile_development_list)
	EventBus.road_built.connect(update_road_list)
func update_tile_development_list( player_name : String, position : Vector2i, tile_development : TileDevelopment): 
	#print("TD list updated")
	tile_development_list[position] = { "name" : player_name, "TD" : tile_development}

func update_road_list(road_path: Array): 
	var road = Road.new()
	for pos in road_path: 
		road_list.set(pos,road)

func update_good_stockpile():
	for id in tile_development_list:
		tile_development_list[id]["TD"].add_goods_to_stockpile()
	
			

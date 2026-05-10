extends Node

var tile_development_list : Dictionary[Vector2i,TileDevelopment]

var road_list : Dictionary[Vector2i,Road]

# Road section


func update_tile_development_list( player_controller : PlayerController, position : Vector2i, tile_development : TileDevelopment): 
	tile_development_list.set(position,tile_development)
	player_controller.player_data.all_players_TD.set(position,tile_development)

	
func update_road_list(position : Vector2i, road : Road): 
	road_list.set(position,road)

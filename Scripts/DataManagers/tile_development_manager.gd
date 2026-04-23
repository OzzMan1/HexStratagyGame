extends Node

var tile_development_list : Dictionary[Vector2i,TileDevelopment]



func update_tile_development_list(position : Vector2i, tile_development : TileDevelopment): 
	tile_development_list.set(position,tile_development)
	

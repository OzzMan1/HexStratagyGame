extends Node
@onready var road_layer_left: TileMapLayer = %road_layer_left
@onready var road_layer_right: TileMapLayer = %road_layer_right
@onready var road_layer_bottom_left: TileMapLayer = %road_layer_bottom_left
@onready var road_layer_top_right: TileMapLayer = %road_layer_top_right
@onready var road_layer_top_left: TileMapLayer = %road_layer_top_left
@onready var road_layer_bottom_right: TileMapLayer = %road_layer_bottom_right

var road_atlas_id = 0

var road_layer_arr = []



func _ready() -> void:
	road_layer_arr = [road_layer_left,road_layer_right,road_layer_bottom_left,road_layer_top_right,road_layer_top_left,road_layer_bottom_right]

func display_road(path : Array, all_layer_atlas_coords : Array,):
	var arr_index = 0
	for layer_atlas_coord in all_layer_atlas_coords:
		for pos in layer_atlas_coord.keys(): 
			var atlas_coord = layer_atlas_coord.get(pos)
			road_layer_arr[arr_index].set_cell(pos,road_atlas_id,atlas_coord)
			
			
		arr_index += 1 

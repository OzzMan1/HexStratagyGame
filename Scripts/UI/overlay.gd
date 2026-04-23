extends Node2D

@onready var overlay_map: TileMapLayer = %overlay_map
@onready var unit_movement_map: TileMapLayer = %unit_movement_order

@onready var tile_development_map: TileMapLayer = $"../../Tilemaps/tile_development_map"

## Overlay Coords TD RE 
var RE_to_overlay_coord : Dictionary[String,Vector2i] = {
	"iron" : Vector2i(0,1),
	"forest" : Vector2i(1,1),
	"stone" : Vector2i(0,1),
	"industrial" : Vector2i(0,4)
}





func update_overlay(tiles_to_overlay,overlay_coord):
	clear_overlay_maps()
	overlay_map.modulate.a = 0.5
	for tile in tiles_to_overlay:
		overlay_map.set_cell(tile,0,overlay_coord)
		
		
func select_unit(tiles_to_overlay):
	
	update_overlay(tiles_to_overlay,Vector2i(0,0))
	
func tile_development_overlay(tiles_to_overlay):
	
	update_overlay(tiles_to_overlay,Vector2i(2,0))

func update_tile_developments(tile, td):
	print(RE_to_overlay_coord.get(td))
	tile_development_map.set_cell(tile,0,RE_to_overlay_coord.get(td))


func move_unit_overlay_update(path_in_range,path):
	clear_overlay_maps()
	
	# Spawn unit at root
	unit_movement_map.set_cell((path_in_range[path_in_range.size() - 1]),0,Vector2i(3,4))
	
	# Clean Path 
	path.remove_at(path.size() - 1) 
	path_in_range.remove_at(path_in_range.size() - 1) 
	path_in_range.remove_at(0)
	
	# Create Path 
	unit_movement_map.modulate.a = 0.5
	for tile in path: 
		unit_movement_map.set_cell(tile,0,Vector2i(0,4))
	for tile in path_in_range:
		unit_movement_map.set_cell(tile,0,Vector2i(1,4))
		

func clear_overlay_maps():
	overlay_map.clear()
	unit_movement_map.clear()

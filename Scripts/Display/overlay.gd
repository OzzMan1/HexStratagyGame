extends Node2D

@onready var overlay_map: TileMapLayer = %overlay_map
@onready var unit_movement_map: TileMapLayer = %unit_movement_order



# General info 
var overlay_atlas_id = 0


# Tile Development overlay data 
var re_highlight = Vector2i(2,0)
var possible_td_connection = Vector2i(0,0)


var select_unit_highlight = Vector2i(0,0)
## Overlay Coords TD RE 


# We need to have single overlay map 
# Then tile map for TDs 

func overlay_init():
	overlay_map.clear()
	unit_movement_map.clear()
	overlay_map.modulate.a = 0.5

func central_overlay_update(tile_map_coord, atlas_id, atlas_coord):

	overlay_map.set_cell(tile_map_coord,atlas_id,atlas_coord)
#
#func update_multiple_tiles(tiles_to_overlay, atlas_id, atlas_coord):
	#clear_overlay_maps()
	#overlay_map.modulate.a = 0.5
	#for tile_map_coord in tiles_to_overlay:
		#overlay_map.set_cell(tile_map_coord,atlas_id,atlas_coord)
#



func RE_overlay(tiles_to_overlay):
	overlay_init()
	for tile_map_coord in tiles_to_overlay:
		overlay_map.set_cell(tile_map_coord,overlay_atlas_id,re_highlight)

func td_connection_overlay(tiles_to_overlay):
	overlay_init()
	for tile_map_coord in tiles_to_overlay:
		overlay_map.set_cell(tile_map_coord,overlay_atlas_id,possible_td_connection)


# move to new file

#
#
#func update_overlay(tiles_to_overlay,overlay_coord):
	#clear_overlay_maps()
	#overlay_map.modulate.a = 0.5
	#for tile in tiles_to_overlay:
		#overlay_map.set_cell(tile,overlay_atlas_id,overlay_coord)
		#
		#
#func select_unit(tiles_to_overlay):
	#
	#update_overlay(tiles_to_overlay,select_unit_highlight)
	#
#func move_unit_overlay_update(path_in_range,path):
	#clear_overlay_maps()
	#
	## Spawn unit at root
	#unit_movement_map.set_cell((path_in_range[path_in_range.size() - 1]),0,Vector2i(3,4))
	#
	## Clean Path 
	#path.remove_at(path.size() - 1) 
	#path_in_range.remove_at(path_in_range.size() - 1) 
	#path_in_range.remove_at(0)
	#
	## Create Path 
	#unit_movement_map.modulate.a = 0.5
	#for tile in path: 
		#unit_movement_map.set_cell(tile,0,Vector2i(0,4))
	#for tile in path_in_range:
		#unit_movement_map.set_cell(tile,0,Vector2i(1,4))
		#

func clear_overlay_maps():
	overlay_map.clear()
	unit_movement_map.clear()

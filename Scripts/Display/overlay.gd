extends Node2D

@onready var overlay_map: TileMapLayer = %overlay_map
@onready var unit_movement_map: TileMapLayer = %unit_movement_order

@onready var td_connections: Node2D = %td_connections
@onready var build_system: Node2D = %build_system


# General info 
var overlay_atlas_id = 0


# Tile Development overlay data 
var re_highlight = Vector2i(2,0)

var td_connection_atlas = Vector2i(0,1)
var possible_td_connection_coord = Vector2i(0,0)
var select_unit_highlight = Vector2i(0,0)
var build_unit_highlight = Vector2i(0,0)



func _ready() -> void:

	build_system.build_obj_selected.connect(build_obj_overlay)

func clear_overlay_maps():
	overlay_map.clear()
	unit_movement_map.clear()

func overlay_init():
	overlay_map.clear()
	unit_movement_map.clear()
	overlay_map.modulate.a = 0.5

func central_overlay_update(tile_map_coord, atlas_id, atlas_coord):

	overlay_map.set_cell(tile_map_coord,atlas_id,atlas_coord)
#
func update_multiple_tiles(tiles_to_overlay, atlas_id, atlas_coord):
	overlay_map.modulate.a = 0.5
	for tile_map_coord in tiles_to_overlay:
		overlay_map.set_cell(tile_map_coord,atlas_id,atlas_coord)

func RE_overlay(tiles_to_overlay):
	overlay_init()
	for tile_map_coord in tiles_to_overlay:
		overlay_map.set_cell(tile_map_coord,overlay_atlas_id,re_highlight)

func update_td_connection(possible_td_connections, td_connections):
	overlay_init()
	update_multiple_tiles(possible_td_connections,0,possible_td_connection_coord)
	update_multiple_tiles(td_connections,0,td_connection_atlas)

func build_obj_overlay(build_obj):
	if build_obj.create_location_overlay:
		var obj_tiles = build_obj.overlay_tiles
		var obj_tile_highlight = build_obj.tile_highlight
		update_multiple_tiles(obj_tiles, overlay_atlas_id,obj_tile_highlight)



func select_unit(tiles_to_overlay):
	
	update_multiple_tiles(tiles_to_overlay,overlay_atlas_id,select_unit_highlight)
	

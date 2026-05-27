extends Node2D

# This system should update a tile map that displays an overlay for the players actions 
	# It needs to know which tiles and which colour 

# The system should only handle updating the tile overlay map, receiving the tiles and colours externally
	# Clear Map
	# Update Tiles

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

func clear_overlay_maps(player_controller):
	player_controller.overlay_map.clear()

func overlay_init(player_controller):
	player_controller.overlay_map.clear()
	player_controller.overlay_map.modulate.a = 0.5

func update_multiple_tiles(player_controller,tiles_to_overlay, atlas_id, atlas_coord):
	player_controller.overlay_map.modulate.a = 0.5
	for tile_map_coord in tiles_to_overlay:
		player_controller.overlay_map.set_cell(tile_map_coord,atlas_id,atlas_coord)


func update_td_connection(player_controller,possible_td_connections, td_connections):
	overlay_init(player_controller)
	update_multiple_tiles(player_controller,possible_td_connections,0,possible_td_connection_coord)
	update_multiple_tiles(player_controller,td_connections,0,td_connection_atlas)


func select_unit(player_controller,tiles_to_overlay):
	
	update_multiple_tiles(player_controller,tiles_to_overlay,overlay_atlas_id,select_unit_highlight)
	

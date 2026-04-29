extends Node

@onready var tile_development_map: TileMapLayer = %tile_development_map

var tile_developement_atlas_id = 0

var RE_to_overlay_coord : Dictionary[String,Vector2i] = {
	"iron" : Vector2i(0,1),
	"forest" : Vector2i(1,1),
	"stone" : Vector2i(0,1),
	"industrial" : Vector2i(0,4),
	"road" : Vector2i(2,1),
}

func update_tile_development_tile_map(tile, td):
	tile_development_map.set_cell(tile,tile_developement_atlas_id,RE_to_overlay_coord.get(td))

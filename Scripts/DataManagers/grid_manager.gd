extends Node2D
@onready var tile_map_layer: TileMapLayer = %map_layer
@export var archer_scene: PackedScene

@onready var terrain_map: TileMapLayer = %map_layer
@onready var resource_improvements: TileMapLayer = %resource_improvements


# Data will be stored on tilemap coordinates 
# Unit movement will be calculated through Axial coordiantes 
var grid_x_max = 3
var grid_y_max = 5

var desert_rsrc = preload("res://Resources/Terrain/desert.tres")
var water_rsrc = preload("res://Resources/Terrain/water.tres")
var hill_rsrc = preload("res://Resources/Terrain/hill.tres")
var plains_rsrc = preload("res://Resources/Terrain/plains.tres")

var forest_rsrc = preload("res://Resources/TileImprovements/forest.tres")
var iron_rsrc = preload("res://Resources/TileImprovements/iron.tres")
var stone_rsrc = preload("res://Resources/TileImprovements/stone.tres")


var terrain_atlas_coords : Dictionary[Vector2i, TerrainData]= {
	 Vector2i(0,2): desert_rsrc,
	 Vector2i(1,2): water_rsrc,
	 Vector2i(2,2): hill_rsrc,
	 Vector2i(3,2): plains_rsrc,
}
var rsrc_improvement_atlas_coords : Dictionary[Vector2i, ResourceImprovementData]= {
	 Vector2i(2,1): forest_rsrc,
	 Vector2i(0,3): iron_rsrc,
	 Vector2i(3,1): stone_rsrc,
}

var terrain_grid : Dictionary[Vector2i,TerrainData]= {}
var re_grid : Dictionary = {}


func _ready() -> void:

	set_up_grid(terrain_map, terrain_atlas_coords, terrain_grid)
	set_up_grid(resource_improvements, rsrc_improvement_atlas_coords, re_grid)
func set_up_grid(tile_map, rsrc_atlas_coord, grid ):
	var cells = tile_map.get_used_cells()

	for cell in cells: 
		var atlas_coords = tile_map.get_cell_atlas_coords(cell)
		if rsrc_atlas_coord.has(atlas_coords):
			grid[cell] = rsrc_atlas_coord[atlas_coords]
		else:
			push_warning("No data mapped for atlas coords: %s at cell %s" % [atlas_coords, cell])

# Unit Global list 
var unit_list = {}

func check_bounds(tile_pos: Vector2i) -> bool:
	var x = tile_pos.x
	var y = tile_pos.y 
	
	if (x <= grid_x_max and x >= 0) and (y <= grid_y_max and y >= 0):
		return true 
	else:
		return false

func get_tile_pos(world_pos : Vector2) -> Vector2i:
	return tile_map_layer.local_to_map(world_pos) 

func get_world_pos(tile_pos : Vector2i) -> Vector2:
	return tile_map_layer.map_to_local(tile_pos) 

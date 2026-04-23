extends Node2D
@onready var tile_map_layer: TileMapLayer = %map_layer
@export var archer_scene: PackedScene



# Data will be stored on tilemap coordinates 
# Unit movement will be calculated through Axial coordiantes 
var grid_x_max = 3
var grid_y_max = 5
var terrain_grid : Dictionary = {
	Vector2i(0,0): preload("res://Resources/plains.tres"),
	Vector2i(0,1): preload("res://Resources/plains.tres"),
	Vector2i(0,2): preload("res://Resources/plains.tres"),
	Vector2i(0,3): preload("res://Resources/plains.tres"),
	Vector2i(0,4): preload("res://Resources/plains.tres"),
	Vector2i(0,5): preload("res://Resources/plains.tres"),
	Vector2i(1,0): preload("res://Resources/plains.tres"),
	Vector2i(1,1): preload("res://Resources/water.tres"),
	Vector2i(1,2): preload("res://Resources/water.tres"),
	Vector2i(1,3): preload("res://Resources/plains.tres"),
	Vector2i(1,4): preload("res://Resources/plains.tres"),
	Vector2i(1,5): preload("res://Resources/plains.tres"),
	Vector2i(2,0): preload("res://Resources/plains.tres"),
	Vector2i(2,1): preload("res://Resources/plains.tres"),
	Vector2i(2,2): preload("res://Resources/water.tres"),
	Vector2i(2,3): preload("res://Resources/plains.tres"),
	Vector2i(2,4): preload("res://Resources/plains.tres"),
	Vector2i(2,5): preload("res://Resources/plains.tres"),
	Vector2i(3,0): preload("res://Resources/plains.tres"),
	Vector2i(3,1): preload("res://Resources/plains.tres"),
	Vector2i(3,2): preload("res://Resources/plains.tres"),
	Vector2i(3,3): preload("res://Resources/plains.tres"),
	Vector2i(3,4): preload("res://Resources/plains.tres"),
	Vector2i(3,5): preload("res://Resources/plains.tres"),
}
var re_grid : Dictionary = {
	Vector2i(0,3) : preload("res://Resources/iron.tres"),
	Vector2i(1,5) : preload("res://Resources/stone.tres"),
	Vector2i(0,5) : preload("res://Resources/stone.tres"),	
	Vector2i(2,1) : preload("res://Resources/forest.tres"),
	Vector2i(3,1) : preload("res://Resources/forest.tres"),
	Vector2i(3,0) : preload("res://Resources/forest.tres")

} 



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

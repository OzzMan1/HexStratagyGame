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
var unit_list_local = {}

# 
# Unit Global liost 

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


func get_unit_list_local():
	return unit_list_local
#
func end_turn_move_update(unit : Unit, dest : Vector2i):
	unit.position = get_world_pos(dest)
	unit.tile_pos = dest 
	unit.set_alpha_value()

#
#func update_unit_list_local(unit : Unit, target: Vector2i, previous_pos : Variant = null):		
		## assign it to the unit grid
		#unit_list_local.set(target,unit)
		## erase the value at the previous position
		#if unit_list_local.has(previous_pos):
			#unit_list_local.erase(previous_pos)
		 #
		## move units position 
		#unit.position = get_world_pos(target)
		#unit.tile_pos = target 
#
#
#func spawn_unit_test(mouse_pos):
	#
	#var tile_pos = get_tile_pos(mouse_pos)
	## Check if Unit is there, if not then we can spawn a new unit and add it as a child
	#if !unit_list_local.has(tile_pos):
		#var new_unit = archer_scene.instantiate()
		#update_unit_list_local(new_unit,tile_pos)	
		##print("Grid manager spwan unit test: ", unit_list_local)
		#new_unit.position = get_world_pos(tile_pos)
		#new_unit.tile_pos = tile_pos 
		#add_child(new_unit)
	#elif unit_list_local.has(tile_pos): 
		#print("Cant build here, there is unit: ", unit_list_local.get(tile_pos).name)

#=

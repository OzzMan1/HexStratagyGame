extends Node

# Enum for road types 
@onready var path_finder: Node2D = %PathFinder
@onready var tile_developement_manager: Node2D = %TileDevelopementManager


enum road_dir {
	LEFT,
	RIGHT,
	BOTTOM_LEFT,
	TOP_RIGHT,
	TOP_LEFT,
	BOTTOM_RIGHT,
} 
var dir_to_road_atlas_coord = {
	road_dir.LEFT : Vector2i(0,0),
	road_dir.RIGHT: Vector2i(1,0),
	road_dir.BOTTOM_LEFT: Vector2i(2,0),
	road_dir.TOP_RIGHT: Vector2i(0,1),
	road_dir.TOP_LEFT: Vector2i(1,1),
	road_dir.BOTTOM_RIGHT: Vector2i(2,1),
}
var directions: Array[Vector2i] = [
Vector2i(-1, 0),
Vector2i(1, 0),
Vector2i(-1, 1), 
Vector2i(1, -1), 
Vector2i(0, -1),
Vector2i(0, 1), 
]
var axial_vector_to_direction : Dictionary[Vector2i, road_dir] = {
Vector2i(-1, 0) : road_dir.LEFT,
Vector2i(1, 0) : road_dir.RIGHT,
Vector2i(-1, 1) : road_dir.BOTTOM_LEFT, 
Vector2i(1, -1) : road_dir.TOP_RIGHT, 
Vector2i(0, -1) : road_dir.TOP_LEFT,
Vector2i(0, 1) : road_dir.BOTTOM_RIGHT, 
}



func create_road_display( path : Array) -> Array:
	# turn to array of arrays
	var road_layer_1_sprite_coords = {}
	var road_layer_2_sprite_coords = {}
	var road_layer_3_sprite_coords = {}
	var road_layer_4_sprite_coords = {}
	var road_layer_5_sprite_coords = {}
	var road_layer_6_sprite_coords = {}
	var road_layer_arr = [road_layer_1_sprite_coords,road_layer_2_sprite_coords,road_layer_3_sprite_coords,road_layer_4_sprite_coords,
	road_layer_5_sprite_coords,road_layer_6_sprite_coords]

		
	var current 
	var next  
	

	for i in range(0,path.size()-1):
		
		current =  path[i]
		next = path[i+1]
		#print("current ", current)
		var dir = calculate_dir(current,next)
		road_layer_arr[dir].set(current,dir_to_road_atlas_coord.get(dir))
		dir = calculate_dir(next,current)
		road_layer_arr[dir].set(next,dir_to_road_atlas_coord.get(dir))


	return road_layer_arr
	



func calculate_dir(current_pos : Vector2i, next_pos : Vector2i):
	current_pos = path_finder.oddr_to_axial(current_pos)
	next_pos = path_finder.oddr_to_axial(next_pos)
	#print ("axial Dir ",axial_vector_to_direction.get(next_pos - current_pos))
	return axial_vector_to_direction.get(next_pos - current_pos)

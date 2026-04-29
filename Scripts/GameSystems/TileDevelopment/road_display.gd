extends Node

# Enum for road types 
@onready var path_finder: Node2D = %PathFinder
@onready var tile_development_map: TileMapLayer = %tile_development_map

enum Directions {
	TOP_LEFT,
	TOP_RIGHT,
	RIGHT,
	BOTTOM_RIGHT,
	BOTTOM_LEFT,
	LEFT,
} 

var directions: Array[Vector2i] = [
Vector2i(0, -1),
Vector2i(1, -1),
Vector2i(1, 0), 
Vector2i(0, 1), 
Vector2i(-1, 1),
Vector2i(-1, 0), 
]
var axial_vector_to_direction : Dictionary[Vector2i, Directions] = {
	Vector2i(0, -1) : Directions.TOP_LEFT,
	Vector2i(1, -1) : Directions.TOP_RIGHT,
	Vector2i(1, 0) : Directions.RIGHT, 
	Vector2i(0, 1) : Directions.BOTTOM_RIGHT, 
	Vector2i(-1, 1) : Directions.BOTTOM_LEFT,
	Vector2i(-1, 0) : Directions.LEFT, 
}

func create_road_display(path : Array) -> Array:
		var tile_map_coords = []
		var target = path.back()

		if path.size() >= 3: 
			
			var last = path[0]
			var current =  path[1]
			var next = path[2]
			
			for i in range(1,path.size()-1):
				last = path[i-1]
				current =  path[i]
				next = path[i+1]
				tile_map_coords.append(decide_which_road(current, last, next)) 
		
		# We need to save road path and which tile map coords to use
		return tile_map_coords
		


func decide_which_road(current_pos : Vector2i, last_pos : Vector2i, next_pos : Vector2i ):
	current_pos = path_finder.oddr_to_axial(current_pos)
	last_pos = path_finder.oddr_to_axial(last_pos)
	next_pos = path_finder.oddr_to_axial(next_pos)


	
	var previous_pos_dir = axial_vector_to_direction.get(last_pos - current_pos)
	var next_pos_dir = axial_vector_to_direction.get(next_pos - current_pos)
	var next_prev = [next_pos_dir,previous_pos_dir]
	match next_prev:
		# Diagonal left
		
		[Directions.TOP_LEFT, Directions.BOTTOM_LEFT], \
		[Directions.BOTTOM_LEFT, Directions.TOP_LEFT]:
			return Vector2i(3, 0)

		# Diagonal right
		[Directions.TOP_RIGHT, Directions.BOTTOM_RIGHT], \
		[Directions.BOTTOM_RIGHT, Directions.TOP_RIGHT]:
			return Vector2i(3, 1)

		# Horizontal
		[Directions.LEFT, Directions.RIGHT], \
		[Directions.RIGHT, Directions.LEFT]:
			return Vector2i(1,0)

		# Upper-left ↔ right
		[Directions.TOP_LEFT, Directions.RIGHT], \
		[Directions.RIGHT, Directions.TOP_LEFT]:
			return Vector2i(0, 2)

		# Upper-right ↔ left
		[Directions.TOP_RIGHT, Directions.LEFT], \
		[Directions.LEFT, Directions.TOP_RIGHT]:
			return Vector2i(2, 2)

		# Bottom-left ↔ right
		[Directions.BOTTOM_LEFT, Directions.RIGHT], \
		[Directions.RIGHT, Directions.BOTTOM_LEFT]:
			
			return Vector2i(0, 0)

		# Bottom-right ↔ left
		[Directions.BOTTOM_RIGHT, Directions.LEFT], \
		[Directions.LEFT, Directions.BOTTOM_RIGHT]:
			return Vector2i(2, 0)
		
		[Directions.BOTTOM_LEFT, Directions.TOP_RIGHT], \
		[Directions.TOP_RIGHT, Directions.BOTTOM_LEFT]:
			return Vector2i(0,1)

		[Directions.TOP_LEFT, Directions.BOTTOM_RIGHT], \
		[Directions.BOTTOM_RIGHT, Directions.TOP_LEFT]:
			return Vector2i(2,1)

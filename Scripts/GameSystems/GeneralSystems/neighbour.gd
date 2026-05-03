extends Node

@onready var grid_manager: Node2D = %GridManager


var directions: Array[Vector2i] = [
Vector2i(0, -1),
Vector2i(1, -1),
Vector2i(1, 0), 
Vector2i(0, 1), 
Vector2i(-1, 1),
Vector2i(-1, 0), 
]

func neighbours(player_controller : PlayerController,  current_position:Vector2i, graph = null ) -> Array[Vector2i]:  
	graph.keys().map(func(x): return player_controller.oddr_to_axial(x) )
	current_position = player_controller.oddr_to_axial(current_position)
	
	
	var possible_directions: Array[Vector2i] = []
	for direction in directions: 
		var new_dir = direction + current_position
		new_dir = player_controller.axial_to_oddr(new_dir)
		
		if graph != null:
			if grid_manager.check_bounds(new_dir) and graph.has(new_dir):
					possible_directions.append(new_dir)
		else: 
			if grid_manager.check_bounds(new_dir): 
				possible_directions.append(new_dir)
	return possible_directions

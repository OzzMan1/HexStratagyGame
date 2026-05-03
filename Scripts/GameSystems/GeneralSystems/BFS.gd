extends Node
@onready var neighbour: Node2D = %neighbour


func BFS(player_controller : PlayerController, start : Vector2i ,graph = null, search_criteria : Dictionary = {}, max_range : int = 1000) -> Array:
	var queue = [start]
	var visited = []
 
	var curr_range = 0
	var return_vals = []

	
	
	while !queue.is_empty() and curr_range <= max_range:
		var curr = queue.pop_front()
		visited.append(curr)
		for v in neighbour.neighbours(player_controller,curr,graph):
			if v not in visited:
				if search_criteria.has(v):
					return_vals.append(v)
				queue.append(v)	
				
		curr_range +=1 
		
	return return_vals

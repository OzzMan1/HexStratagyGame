extends Resource


class_name TerrainData

@export var name: String 
@export var movement_cost: int 

func on_select(player_controller,selected_pos):
	print("Selected Terrain ") 
	
func deselect(player_controller):
	print(" De selected terrain")

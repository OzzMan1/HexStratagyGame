extends Node2D

@onready var movement_map: TileMapLayer = %movement_map
@onready var unit_movement_map: TileMapLayer = %unit_movement_order


func select_unit_overlay_update(path_in_range):
	clear_overlay_maps()
	movement_map.modulate.a = 0.5
	for tile in path_in_range:
		movement_map.set_cell(tile,0,Vector2i(0,0))
	
func move_unit_overlay_update(path_in_range,path):
	clear_overlay_maps()
	
	# Spawn unit at root
	unit_movement_map.set_cell((path_in_range[path_in_range.size() - 1]),0,Vector2i(3,4))
	
	# Clean Path 
	path.remove_at(path.size() - 1) 
	path_in_range.remove_at(path_in_range.size() - 1) 
	path_in_range.remove_at(0)
	
	# Create Path 
	unit_movement_map.modulate.a = 0.5
	for tile in path: 
		unit_movement_map.set_cell(tile,0,Vector2i(0,4))
	for tile in path_in_range:
		unit_movement_map.set_cell(tile,0,Vector2i(1,4))
		
		
func display_all_unit_orders(unit_paths : Dictionary[Unit, Array] ):
	clear_overlay_maps()
	for path_group in unit_paths.values(): 
		var path = path_group[0]
		var path_in_range = path_group[1]
		# Spawn unit at root
		unit_movement_map.set_cell((path_in_range[path_in_range.size() - 1]),0,Vector2i(4,9))
		path.remove_at(path.size() - 1)
		path.remove_at(0) 
		path_in_range.remove_at(path_in_range.size() - 1) 
		path_in_range.remove_at(0)
		for tile in path: 
			unit_movement_map.set_cell(tile,0,Vector2i(1,9))
		for tile in path_in_range:
			unit_movement_map.set_cell(tile,0,Vector2i(2,9))	
	

func clear_overlay_maps():
	movement_map.clear()
	unit_movement_map.clear()

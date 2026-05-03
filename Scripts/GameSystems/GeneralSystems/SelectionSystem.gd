extends Node2D

@onready var path_finder: Node2D = %PathFinder
@onready var overlay_tilemap = %OverlayUI

var current_selected_unit : Unit 



# click, get first object
# click again, get second object





func get_objects_at_pos(player_controller : PlayerController, clicked_pos : Vector2i):

	var objects_at_pos = []

	# Checking for Unit
	var target_to_unit = player_controller.player_data.target_to_unit
	if target_to_unit.has(clicked_pos):
		objects_at_pos.append(target_to_unit.get(clicked_pos))
	
		# Checking for Tile Development
	if player_controller.tile_developement_manager.tile_development_list.has(clicked_pos):
		objects_at_pos.append(player_controller.tile_developement_manager.tile_development_list.get(clicked_pos))
	
	# Checking for Resource improvement
	if player_controller.grid_manager.re_grid.has(clicked_pos):
		if player_controller.grid_manager.re_grid[clicked_pos].resource_improvment_type == "iron":
			objects_at_pos.append(player_controller.grid_manager.re_grid[clicked_pos])
		elif player_controller.grid_manager.re_grid[clicked_pos].resource_improvment_type == "stone":
			objects_at_pos.append(player_controller.grid_manager.re_grid[clicked_pos])
		elif player_controller.grid_manager.re_grid[clicked_pos].resource_improvment_type == "forest":
			objects_at_pos.append(player_controller.grid_manager.re_grid[clicked_pos])
	## Checking for Terrain
	if player_controller.grid_manager.terrain_grid.has(clicked_pos):
		objects_at_pos.append(player_controller.grid_manager.terrain_grid.get(clicked_pos))
	#

	return objects_at_pos
	
# [unit, iron, sheep]
func get_clicked_object(player_controller : PlayerController, clicked_pos : Vector2i): 
	# if the user has clicked this position before then we iterate the last clicked item 
	
	var objects = get_objects_at_pos(player_controller,clicked_pos)  
	if objects.is_empty():
		return null
	
	if clicked_pos == player_controller.player_data.last_clicked_pos: 
		player_controller.player_data.last_clicked_index = (player_controller.player_data.last_clicked_index + 1) % objects.size()
	else:
		player_controller.player_data.last_clicked_index = 0
		player_controller.player_data.last_clicked_pos = clicked_pos
	
	
	return objects[player_controller.player_data.last_clicked_index]
	

		
	#var target_to_unit = player_controller.player_data.target_to_unit
	#if target_to_unit.has(clicked_pos):
		#return target_to_unit.get(clicked_pos)
	#return null

func select_unit(player_controller : PlayerController, pos : Vector2i):	
	#Get reference to unit at pos 
	current_selected_unit = player_controller.player_data.target_to_unit.get(pos)
	
	var axial_pos = path_finder.oddr_to_axial(pos)
	path_finder.shortest_path_to_all_tiles(player_controller,axial_pos)
	
	path_finder.new_tiles_in_range = path_finder.find_in_range(current_selected_unit.current_num_of_moves)
	var tiles_in_range_offset = path_finder.new_tiles_in_range.map(func(x): return path_finder.axial_to_oddr(x))
	
	overlay_tilemap.select_unit(tiles_in_range_offset)

	

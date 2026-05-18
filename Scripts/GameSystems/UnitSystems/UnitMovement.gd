extends Node


# VARIABLES
@onready var grid_manager: Node2D = %GridManager
@onready var path_finder: Node2D = %PathFinder
@onready var overlay_tilemap = %OverlayUI
@onready var unit_manager = %UnitManager



func cost_function(player_controller, position):
	if grid_manager.unit_list.has(position):
		return INF
	else:
		return grid_manager.terrain_grid.get(position).movement_cost


# Select unit -> Show path 

# Right click tile to move to -> Implement move

var all_paths_offset : Array[Array] 
var all_path_map_unit : Dictionary[Unit, Array] 
var unit_map_prev_target : Dictionary[Unit,Array]

## make it display while holding right click

func calculate_unit_move_path(new_pos : Vector2i, previous_pos : Vector2i, prev_list, tiles_in_range):
# we convert to axial coordiantes as that.....
		new_pos = path_finder.oddr_to_axial(new_pos)
		previous_pos = path_finder.oddr_to_axial(previous_pos)
	
	
		# Work backwards from the new position accessing the previous node in the shortest path
		var current_pos = prev_list[new_pos]
		var path : Array[Vector2i] = [current_pos]
		while current_pos != previous_pos:
				current_pos = prev_list.get(current_pos)
				path.append(current_pos)
		path.push_front(new_pos)

		var path_in_range : Array[Vector2i]
		for pos in path:
			if pos in tiles_in_range:
				path_in_range.append(pos)
	
		return {
  				"full_path": path,
   				"in_range": path_in_range}

# Given a unit and a target, paths finds the path to get to target
func set_unit_path(player_controller : PlayerController,  selected_unit : Unit, new_pos : Vector2i, previous_pos : Vector2i ):	
	#  Check the new position is in the game bounds 
	if grid_manager.check_bounds(new_pos) and new_pos != previous_pos:

		var prev_list =  selected_unit.prev_list
		var tiles_in_range = selected_unit.tiles_in_range
	
		# calculate unit path
		var results = calculate_unit_move_path(new_pos,previous_pos, prev_list, tiles_in_range)
		var path = results.get("full_path")
		var path_in_range = results.get("in_range")
	
		# Convert to coordinates for godot gird  
		var path_in_range_oddr = path_in_range.map(func(x): return path_finder.axial_to_oddr(x))	
		var path_oddr = path.map(func(x): return path_finder.axial_to_oddr(x))
		
		# Create unit prev, target
		var prev = path_in_range_oddr[path_in_range_oddr.size()-1]
		var target =path_in_range_oddr[0]

		unit_manager.update_unit_position(player_controller,selected_unit,target )
		unit_manager.update_unit_list(player_controller, selected_unit, target, prev)
		## Move to new funciton
		selected_unit.update_current_number_of_moves(path_in_range.size()-1)

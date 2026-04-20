extends Node


# VARIABLES
@onready var grid_manager: Node2D = %GridManager
@onready var path_finder: Node2D = %GameSystems/PathFinder
@onready var unit_movemement_overlay = %UnitMovementOverlay
@onready var unit_manager = %UnitManager



var all_paths_offset : Array[Array] 
var all_path_map_unit : Dictionary[Unit, Array] 
var unit_map_prev_target : Dictionary[Unit,Array]



func calculate_unit_move_path(new_pos : Vector2i, previous_pos : Vector2i):
# we convert to axial coordiantes as that.....
		new_pos = path_finder.oddr_to_axial(new_pos)
		previous_pos = path_finder.oddr_to_axial(previous_pos)
	
		# Work backwards from the new position accessing the previous node in  the shortest path
		var current_pos = path_finder.prev[new_pos]
		var path : Array[Vector2i] = [current_pos]
		while current_pos != previous_pos:
				current_pos = path_finder.prev.get(current_pos)
				path.append(current_pos)
		path.push_front(new_pos)

		var path_in_range : Array[Vector2i]
		for pos in path:
			if pos in path_finder.new_tiles_in_range:
				path_in_range.append(pos)
	
		return {
  				"full_path": path,
   				"in_range": path_in_range}

# Given a unit and a target, paths finds the path to get to target
func set_unit_path(player_controller : PlayerController,  selected_unit : Unit, new_pos : Vector2i, previous_pos : Vector2i ):	
	#  Check the new position is in the game bounds 
	if grid_manager.check_bounds(new_pos):
		selected_unit.set_alpha_value()

		# calculate unit path
		var results = calculate_unit_move_path(new_pos,previous_pos)
		var path = results.get("full_path")
		var path_in_range = results.get("in_range")
	
		# Convert to coordinates for godot gird  
		var path_in_range_oddr = path_in_range.map(func(x): return path_finder.axial_to_oddr(x))	
		var path_oddr = path.map(func(x): return path_finder.axial_to_oddr(x))
		
		# Pass it to unit overlay
		unit_movemement_overlay.move_unit_overlay_update(path_in_range_oddr.duplicate(true),path_oddr.duplicate(true))
		
		
		# Create unit prev, target
		var prev = path_in_range_oddr[path_in_range_oddr.size()-1]
		var target =path_in_range_oddr[0]
		
		var new_unit_order = unit_order.new(prev,target, selected_unit,path_in_range_oddr.size())
		unit_manager.update_unit_list_local(player_controller,selected_unit, new_unit_order)
		
		
		selected_unit.update_current_number_of_moves(path_in_range.size()-1)
		
		print("unit order stack ", player_controller.player_data.unit_order_stack)
		


func undo_unit_path(player_controller : PlayerController,  selected_unit : Unit):
	# If the player has made a move order, we want them to be able to undo the move 
	# The player should select the moved unit and press crtl z 
	# First we have to check if a different unit has been assigned to the our unit_undo's position, if so then that unit should undo too. 
	# Then we have to check that unit too
	# This can be modlled as a graph problem, finding the directed acyclic grpah 
	# The ndoes are units, and their exists an edge between the nodes if the prev of one node equals the target of another
	# We can use BFS to find the dependency grpah 
	
	if  player_controller.player_data.unit_order_stack.get(selected_unit).size() < 2 :
		return
	
	var conflicting_units = [selected_unit] 
	var queue = [selected_unit]
	
	while !queue.is_empty():
		var curr = queue.pop_front()
		# Look at the current orders (last ones) previous position    
		var curr_prev = player_controller.player_data.unit_order_stack.get(curr).back().prev
		if player_controller.player_data.target_to_unit.has(curr_prev):
			var unit_to_add = player_controller.player_data.target_to_unit.get(curr_prev)  
			queue.append(unit_to_add)
			conflicting_units.append(unit_to_add)
		
	
	conflicting_units.reverse()
	for unit in conflicting_units:
		var current_order = player_controller.player_data.unit_order_stack.get(unit).pop_back()
		var last_order = player_controller.player_data.unit_order_stack.get(unit).pop_back()
		
		player_controller.player_data.target_to_unit.erase(current_order.target)
		unit_manager.update_unit_list_local(player_controller, unit, last_order)
	
	
		unit.reset_alpha_value()
		unit.update_current_number_of_moves(-(current_order.number_of_moves-1))
		print("unit order stack ", player_controller.player_data.unit_order_stack)


func implement_move_orders():

	for unit in all_path_map_unit.keys():
		var path_in_range = all_path_map_unit.get(unit)[1]

		grid_manager.end_turn_move_update(unit,path_in_range[0])
	unit_movemement_overlay.clear_overlay_maps()
	#clear all path orders
	all_paths_offset.clear()
	all_path_map_unit.clear()

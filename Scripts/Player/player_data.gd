extends Node



var local_unit_orders : Array[unit_order]
var unit_order_stack : Dictionary[Unit,Array]
var target_to_unit : Dictionary[Vector2i, Unit]

var has_ended_turn : bool = false

@export var archer_scene: PackedScene

@export var player_name : String 

# For cycling objects
var last_clicked_pos : Vector2i
var last_clicked_object
func get_archer_scene():
	return 	archer_scene


func test():
	print(player_name)



# Each player assigns their local move orders 
# Then at the end fo the turn all the local move orders stored in each players unit_local_list are collected that contains unit, prev, target locations
# We then have to resolve all the movements and apply them to the global move order
# Units have Intiative and move orders are executed in order of initiative 
# A naive approach is to: 

# Dictionary target_to_unit 
# A collision variable that stores the set of units involved, the coordiante and the initiative of which it happens maybe of dictionsary key = position val (unit set,initaitive)
# for each level of intiative 
# 	for curr_unit with current intiative level
#		if target_to_unit(curr_unit.target) is not in the dictionary
# 			add it  
#		else 
# 			if curr_unit.target is not already a collision
#				col = create_Collision([curr_unit,target_to_unit(curr_unit.target)],curr_unit.target, initiative level1 )
#				collisions.add(col)
#			else
#				collisions.set(curr_unit.target) = update unit list
		
				

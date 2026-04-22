extends State

class_name BuildState


# Idle state  ->Press RE button
# Build State -> right click tile

# build state

# init 
# which build object
# on enter 
	# call overlay 
# on exit 

# handle input
# if rclick 
	# send to build system 


var build_obj : Buildable

# buildable objects are the tile developments and road
# how do I add buildable component to something that isnt a scene
func _init(_build_obj : Buildable):
	build_obj = _build_obj

func handle_input(player_controller, event) -> void:
	if event.is_action_pressed("Rclick"):
		player_controller.build_td.build_RE()
		pass 
		
func enter(player_controller) -> void:
	# buildoverlay
	pass
	
func exit(player_controller) -> void:
	# cancel_overlay() 
	pass

	

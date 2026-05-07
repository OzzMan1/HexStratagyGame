extends State

class_name InteractionState 
var state_name : String = "Interaction"


var interaction : Interaction

func _init(_interaction ) -> void:
	interaction = _interaction
func enter(player_controller) -> void:
	interaction.enter(player_controller)
	
func exit(player_controller) -> void:
	interaction.exit(player_controller)
		
func handle_input(player_controller, event) -> void:
	if event.is_action_pressed("click"):
		var pos = player_controller.return_mouse_pos()
		if player_controller.grid_manager.check_bounds(pos):	
			interaction.handle_input(player_controller,event,pos)
	elif event.is_action_pressed("escape"): 
		player_controller.set_state(IdleState.new())

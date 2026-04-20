extends Node2D

var all_local_unit_lists : Dictionary[PlayerController,Array]  
@onready var player_manager: Node2D = $"../../PlayerManager"

@onready var unit_behaviour_resolver: Node2D = $unit_behaviour_resolver

var number_of_players_end_turn = 0 

	
	

# when the player presses end turn
func player_end_turn(player_controller : PlayerController, unit_order_list : Array ):
	# add players data
	all_local_unit_lists.set(player_controller,unit_order_list)	
	
	player_controller.player_data.has_ended_turn = true
	# have all players ended their turn
	
	if have_all_players_ended_turn():
		
		print("turn ended")

	
	
		
# cancel end turn
func player_cancel_end_turn(player_controller : PlayerController):
	player_controller.player_data.has_ended_turn = false
	all_local_unit_lists.erase(player_controller)

func have_all_players_ended_turn() -> bool:
	for player in player_manager.get_player_list():
		if player.player_data.has_ended_turn == false:
			return false
	return true
		

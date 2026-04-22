extends Node2D

@onready var player_manager: Node2D = %PlayerManager



	
	

# when the player presses end turn
func player_end_turn(player_controller : PlayerController, unit_order_list : Array ):
	# add players data
	
	player_controller.player_data.has_ended_turn = true
	# have all players ended their turn
	
	if have_all_players_ended_turn():
		
		print("turn ended")

	
	
		
# cancel end turn
func player_cancel_end_turn(player_controller : PlayerController):
	player_controller.player_data.has_ended_turn = false

func have_all_players_ended_turn() -> bool:
	for player in player_manager.get_player_list():
		if player.player_data.has_ended_turn == false:
			return false
	return true
		

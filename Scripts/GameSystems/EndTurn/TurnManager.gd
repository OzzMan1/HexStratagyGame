extends Node2D

@onready var player_manager: Node2D = %PlayerManager
@onready var td_system: Node2D = %td_system

# when the player presses end turn
func player_end_turn(player_controller : PlayerController ):
	# add players data
	if !player_controller.player_data.has_ended_turn:
		player_controller.player_data.has_ended_turn = true
		print("player: ", player_controller.player_data.player_name, " has ended their turn ")
	else: 
		player_controller.player_data.has_ended_turn = false
		print("player: ", player_controller.player_data.player_name, " has cancled their end turn ")
		
	# have all players ended their turn
	if have_all_players_ended_turn():
		for player in player_manager.get_player_list():
			td_system.update_good_stockpile(player.player_data.all_players_TD)
			player.td_economy.update_economy(player)
			player.unit_manager.update_unit_movement(player.player_data.target_to_unit)
			player_controller.player_data.has_ended_turn = false
		print("turn ended")

	

func have_all_players_ended_turn() -> bool:
	for player in player_manager.get_player_list():
		if player.player_data.has_ended_turn == false:
			return false
	return true
		

extends Node2D

@onready var tile_developement_manager = get_tree().current_scene.find_child("TileDevelopementManager", true, false)
@onready var game_scene: Node2D = $"../.."

var turn_number: int = 1


func player_end_turn(player_controller : PlayerController, has_end_turn: bool ):


	updated_end_turn.rpc(multiplayer.get_unique_id(),has_end_turn)
	# have all players ended their turn
	# if have_all_players_ended_turn():
	# 	tile_developement_manager.update_good_stockpile()
	# 	var player = game_scene.player_controller
	# 	player.td_economy.update_economy(player)
	# 	player.unit_manager.update_unit_movement()
	# 	player.player_data.has_ended_turn = false
	# 	turn_number += 1
	# 	EventBus.turn_number_updated.emit(turn_number)
	# 	print("turn ended")



@rpc("any_peer", "call_local", "reliable") 
func updated_end_turn(player_id, has_end_turn):
	if multiplayer.is_server():
		player_updated_end_turn.rpc(player_id, has_end_turn)

		if have_all_players_ended_turn():
			start_next_turn.rpc()

@rpc("authority", "call_local", "reliable")
func player_updated_end_turn(player_id, end_turn_state):
	NetworkManager.players[player_id]["end_turn"] = end_turn_state 
	#print("Player: ", NetworkManager.players[multiplayer.get_unique_id()]["name"])
	#print(NetworkManager.players)


@rpc("authority", "call_local", "reliable")
func start_next_turn():
	tile_developement_manager.update_good_stockpile()
	var player = game_scene.player_controller
	player.td_economy.update_economy(player)
	player.unit_manager.update_unit_movement()
	player.player_data.has_ended_turn = false
	turn_number += 1
	EventBus.turn_number_updated.emit(turn_number) 

func have_all_players_ended_turn() -> bool:
	#print("CHECKING END TURN")

	for player in NetworkManager.players:
		#print("PLAYER IS: ", NetworkManager.players[player]["name"])
		#print("Have ended turn? ", NetworkManager.players[player]["end_turn"] == true)
		if NetworkManager.players[player]["end_turn"] == false:
			return false
		
	return true
		

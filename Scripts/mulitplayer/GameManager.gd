extends Node



# Scenes 
const LOBBY = preload("res://Scenes/GameScenes/Lobby.tscn")
const MAIN_GAME = preload("res://Scenes/GameScenes/game_scene.tscn")
const START_MENU = preload("res://Scenes/GameScenes/StartMenu.tscn")

# Game Components
const PlayerScene = preload("res://Scenes/GameComponents/player_controller.tscn")
const	 UIScene = preload("res://Scenes/UI/menu_canvas.tscn")

signal players_created 

func _ready() -> void:
	pass


# Server calls this
func assign_players_index():
	var index = 1
	for player in NetworkManager.players:
		NetworkManager.players[player]["index"] = index 
		index +=1
	receive_player_indexes.rpc(NetworkManager.players)	
	print(NetworkManager.players)

@rpc("authority","call_remote" ,"reliable")
func receive_player_indexes(updated_players):
	print("RPC RECEIVED ON ", multiplayer.get_unique_id())
	NetworkManager.players = updated_players


func load_scene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)

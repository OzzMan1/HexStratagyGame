extends Node

var player_to_PC : Dictionary[int, PlayerController]


# Scenes 
const LOBBY = preload("res://Scenes/GameScenes/Lobby.tscn")
const MAIN_GAME = preload("res://Scenes/GameScenes/game_scene.tscn")
const START_MENU = preload("res://Scenes/GameScenes/StartMenu.tscn")

# Game Components


func _ready() -> void:
	NetworkManager.player_connected.connect(map_player_PC)
	


func map_player_PC(player_id):
	# Set up player funciton
	# for each player in Game manager list, we need to set them up and assign them to player manager

	var current_num_players = NetworkManager.players.size()
	var player_name = NetworkManager.players[player_id]["name"]
	var city_pos = generate_player_city_pos(current_num_players)

	# func _init(id : int, _player_name: String, _player_list_index: int, _city_pos : Vector2i):
	player_to_PC[player_id] = PlayerController.new(player_id, player_name, current_num_players,city_pos)
	
	print("player_name ", player_name)
	print(current_num_players)
	print(city_pos)

func generate_player_city_pos(player_pos: int):
	match player_pos:
		1:
			return Vector2i(0,0)
		2:
			return Vector2i(7,7)

func load_scene(scene : PackedScene):

	get_tree().change_scene_to_packed(scene)

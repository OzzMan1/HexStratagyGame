extends Node

var player_to_PC : Dictionary[int, PlayerController]


# Scenes 
const LOBBY = preload("res://Scenes/GameScenes/Lobby.tscn")
const MAIN_GAME = preload("res://Scenes/GameScenes/game_scene.tscn")
const START_MENU = preload("res://Scenes/GameScenes/StartMenu.tscn")

# Game Components
const PlayerScene = preload("res://Scenes/GameComponents/player_controller.tscn")


signal scene_loaded

func _ready() -> void:
	NetworkManager.game_started.connect(create_players)

func create_players():
	#var player_manager = get_tree().root.get_node("GameScene/PlayerManager")	# Set up player funciton
	# for each player in Game manager list, we need to set them up and assign them to player manager
	print(get_tree().current_scene.get_path())
	var player_manager =  get_tree().current_scene.get_node("PlayerManager")
	
	print(player_manager)
	print(NetworkManager.players)
	print("Test")
	for player in NetworkManager.players:
		var current_num_players = NetworkManager.players.size()
		var player_name = NetworkManager.players[player]["name"]
		var city_pos = generate_player_city_pos(current_num_players)
		
		var player_controller = PlayerScene.instantiate()
		player_controller.set_up(player, player_name, current_num_players,city_pos)
		
		player_to_PC[player] = player_controller 
		player_manager.add_child(player_controller)
	
		# func _init(id : int, _player_name: String, _player_list_index: int, _city_pos : Vector2i):
		#player_to_PC[player] = PlayerController.new(player, player_name, current_num_players,city_pos)
		
		print("player_name ", player_name)
		print(current_num_players)
		print(city_pos)

func generate_player_city_pos(player_pos: int):
	match player_pos:
		1:
			return Vector2i(0,0)
		2:
			return Vector2i(7,7)

func load_scene(scene: PackedScene):


	get_tree().change_scene_to_packed(scene)
	# Wait until the scene is assigned

	print("finished")

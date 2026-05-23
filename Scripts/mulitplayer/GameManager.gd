extends Node

var player_to_PC : Dictionary[int, PlayerController]


# Scenes 
const LOBBY = preload("res://Scenes/GameScenes/Lobby.tscn")
const MAIN_GAME = preload("res://Scenes/GameScenes/game_scene.tscn")
const START_MENU = preload("res://Scenes/GameScenes/StartMenu.tscn")

# Game Components
const PlayerScene = preload("res://Scenes/GameComponents/player_controller.tscn")
const UIScene = preload("res://Scenes/UI/menu_canvas.tscn")


signal players_created 

func _ready() -> void:
	pass



func create_players():

	
	
	var player_name = NetworkManager.players[player]["name"]
	var city_pos = generate_player_city_pos()
	
	var player_controller = PlayerScene.instantiate()
	player_controller.name = player_name
	player_controller.set_up(player, player_name, 0,city_pos)

	player_to_PC[player] = player_controller 
	player_manager.add_child(player_controller)
		
	

# func create_players():
# 	#var player_manager = get_tree().root.get_node("GameScene/PlayerManager")	# Set up player funciton
# 	# for each player in Game manager list, we need to set them up and assign them to player manager
# 	print(get_tree().current_scene.get_path())
# 	var player_manager =  get_tree().current_scene.get_node("PlayerManager")
	
# 	print(player_manager)
# 	print(NetworkManager.players)
	
# 	var index = 0 

# 	for player in NetworkManager.players:
# 		index +=1 
# 		var player_name = NetworkManager.players[player]["name"]
# 		var city_pos = generate_player_city_pos(index)
		
# 		var player_controller = PlayerScene.instantiate()
# 		player_controller.name = player_name
# 		player_controller.set_up(player, player_name, index,city_pos)

# 		player_to_PC[player] = player_controller 
# 		player_manager.add_child(player_controller)
		
	


# Player needs references to induvidual UI objects 
# SO we should assign them to the main UI script





func generate_player_city_pos(player_pos: int):
	match player_pos:
		1:
			return Vector2i(0,0)
		2:
			return Vector2i(7,7)

func load_scene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)

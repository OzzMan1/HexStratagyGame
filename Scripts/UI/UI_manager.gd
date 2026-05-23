extends Node

var player_UIs = []

func _ready():
	GameManager.players_created.connect(create_UI)
   
func create_UI():
	# Instantiate 
	

	var id = multiplayer.get_unique_id()

	var player_controller = GameManager.player_to_PC[id]

	var player_ui = GameManager.UIScene.instantiate()
	add_child(player_ui)
	player_ui.name =  "ui_" + NetworkManager.players[id]["name"]
	# assign player to UI 
	player_ui.set_up(player_controller)
	# Assign UI to player (and buttons)
	player_controller.set_player_ui(player_ui)

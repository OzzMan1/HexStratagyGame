extends Node

var player_controller


@onready var ui_canvas: CanvasLayer = $UI_canvas

func _ready():
	
	var id = multiplayer.get_unique_id()
	create_players(id)
	create_UI(id)
	
func create_players(id):
	var player_name = NetworkManager.players[id]["name"]
	print("Player Index ", NetworkManager.players[id]["index"])
	var city_pos = generate_player_city_pos(NetworkManager.players[id]["index"])
	
	player_controller = GameManager.PlayerScene.instantiate()
	player_controller.name = player_name
	player_controller.set_up(id, player_name,city_pos)
	add_child(player_controller)
	
	print("Player: ", player_name, " has been made" )


func create_UI(id):
	var player_ui = GameManager.UIScene.instantiate()
	ui_canvas.add_child(player_ui)
	player_ui.name =  "ui_" + NetworkManager.players[id]["name"]
	# assign player to UI 
	player_ui.set_up(player_controller)
	# Assign UI to player (and buttons)
	player_controller.set_player_ui(player_ui)

func generate_player_city_pos(player_pos: int):
	match player_pos:
		1:
			return Vector2i(0,0)
		2:
			return Vector2i(7,7)

	

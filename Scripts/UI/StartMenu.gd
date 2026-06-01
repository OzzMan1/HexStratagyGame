extends Node


@onready var EnterNameBox: LineEdit = $VBoxContainer/EnterNameBox

func _on_host_pressed() -> void:
	NetworkManager.player_name = EnterNameBox.text.strip_edges()
	NetworkManager.host_game()
	GameManager.load_scene(GameManager.LOBBY)
func _on_join_pressed() -> void:
	NetworkManager.player_name = EnterNameBox.text.strip_edges()

	NetworkManager.join_game()
	await multiplayer.connected_to_server
	GameManager.load_scene(GameManager.LOBBY)
	

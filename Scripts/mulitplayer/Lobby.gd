extends Node



@onready var player_list: VBoxContainer = $centered/PlayerList
@onready var ready_button: Button = %Ready



func _ready() -> void:
	NetworkManager.player_connected.connect(refresh_player_list)
	refresh_player_list()
	
func _on_start_pressed() -> void:
	print("all ready? ", all_players_ready())
	print("players: ", NetworkManager.players)
	if all_players_ready():
		start_game.rpc()


func _on_ready_toggled(toggled_on: bool) -> void:
	set_player_ready.rpc(toggled_on)
# Add player to player_list when join 
func refresh_player_list():
	   # Clear and rebuild the player list UI
	for child in player_list.get_children():
		child.queue_free()

	for id in NetworkManager.players:
		var p = NetworkManager.players[id]
		var label = Label.new()
		var ready_text = "✓" if p["ready"] else "..."
		label.text = "%s  [%s]" % [p["name"], ready_text]
		player_list.add_child(label)



@rpc("any_peer", "call_local", "reliable" )
func set_player_ready(is_ready):
	var id = multiplayer.get_remote_sender_id()
	NetworkManager.players[id]["ready"] = is_ready
	refresh_player_list()

	
func all_players_ready():

	for player in NetworkManager.players:
		if NetworkManager.players[player]["ready"] == false:
			return false
	return true

@rpc("authority", "call_local", "reliable" )
func start_game():
	print("start load scene")
	await GameManager.load_scene(GameManager.MAIN_GAME)
	print("load scene finished")
	#NetworkManager.game_started.emit()

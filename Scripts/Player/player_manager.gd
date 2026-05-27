extends Node

var current_player : PlayerController


# # We have to initialse them in ready as onready vars are only loaded before _ready, rather than var which is loaded before when script is loaded
# # To have playerList be populated we need to assign it duirng ready
func _ready() -> void:
	pass
	#GameManager.create_players(self)
	#current_player = player_list[0]
	#print("Player ", NetworkManager.players[multiplayer.get_unique_id()]["name"])
	#print(NetworkManager.players)
	#GameManager.players_created.emit()





	

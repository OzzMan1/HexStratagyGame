extends Node

#@onready var player_controller: PlayerController = %PlayerController
#
#
#var player_list : Array[PlayerController]
#var current_player : PlayerController
#
#
#
#
#func get_player_list():
	#return player_list
#
#
## # We have to initialse them in ready as onready vars are only loaded before _ready, rather than var which is loaded before when script is loaded
## # To have playerList be populated we need to assign it duirng ready
#func _ready() -> void:
	#
	#GameManager.create_players.rpc()
	#create_player_list()
	#current_player = player_list[0]
	#GameManager.players_created.emit()
#
#
#func create_player_list():
	#for player in self.get_children():
		#player_list.append(player)
#
#
#
#func set_player(player_index : int):
#
	#current_player.isActive = false
	#current_player = player_list[player_index]
	#current_player.isActive = true
	##menu.check_visibility(current_player)
	#print(current_player)
	#
	#
	

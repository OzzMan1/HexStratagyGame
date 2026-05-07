extends Node


@onready var player_controller_2: PlayerController = $PlayerController2
@onready var player_controller: PlayerController = $PlayerController
var player_list : Array[PlayerController]
var current_player : PlayerController


func get_player_list():
	return player_list


# We have to initialse them in ready as onready vars are only loaded before _ready, rather than var which is loaded before when script is loaded
# To have playerList be populated we need to assign it duirng ready
func _ready() -> void:
	player_list = [player_controller, player_controller_2]
	current_player = player_list[0]
	print(player_list)



func set_player(player_index : int):

	current_player.isActive = false
	current_player = player_list[player_index]
	current_player.isActive = true
	
	print(current_player)
	
	
	

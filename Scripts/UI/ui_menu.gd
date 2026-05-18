extends Node

@onready var player_controller: PlayerController = %PlayerController

@onready var end_turn: Button = $End_turn

func check_visibility(current_player):
	if current_player == player_controller:
		self.visible = true 
	else:
		self.visible = false


func _on_end_turn_pressed() -> void:
	player_controller.turn_manager.player_end_turn(player_controller)

func _on_build_td_pressed() -> void:
	player_controller.on_build_td(player_controller)

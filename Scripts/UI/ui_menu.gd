extends Node

var player_controller: PlayerController 

@onready var end_turn: Button = $End_turn

@onready var build_td_menu: VBoxContainer = $HBoxContainer/BuildTDMenu
@onready var select_td_menu: VBoxContainer = $HBoxContainer/SelectTDMenu
@onready var change_good_menu: Control = $ChangeGoodMenu
@onready var city_menu: Control = %city_menu

func set_up(player : PlayerController):
	player_controller = player


func check_visibility(current_player):
	if current_player == player_controller:
		self.visible = true 
	else:
		self.visible = false


func _on_end_turn_pressed() -> void:
	player_controller.turn_manager.player_end_turn(player_controller)

func _on_build_td_pressed() -> void:
	player_controller.on_build_td(player_controller)

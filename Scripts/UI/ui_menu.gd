extends Node

var player_controller: PlayerController 

@onready var select_td_menu: VBoxContainer = $SelectTDMenu
@onready var build_td_menu: VBoxContainer = $BuildTDMenu
@onready var change_good_menu: Control = $ChangeGoodMenu
@onready var city_menu: Control = %city_menu

func set_up(player : PlayerController):
	player_controller = player
	select_td_menu.player_controller = player
	build_td_menu.player_controller = player
	change_good_menu.player_controller = player


func _on_end_turn_pressed() -> void:
	player_controller.turn_manager.player_end_turn(player_controller)

func _on_build_td_pressed() -> void:
	player_controller.on_build_td(player_controller)

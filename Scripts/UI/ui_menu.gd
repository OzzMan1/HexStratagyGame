extends Node

var player_controller: PlayerController 

@onready var select_td_menu: VBoxContainer = $SelectTDMenu
@onready var build_td_menu: VBoxContainer = $BuildTDMenu
@onready var change_good_menu: Control = $ChangeGoodMenu
@onready var city_menu: Control = %city_menu
@onready var turn_number_label: Label = $TurnNumber
@onready var end_turn: Button = $Buttons/End_turn


func _ready() -> void:
	EventBus.turn_number_updated.connect(on_turn_number_updated)
	
func on_turn_number_updated(turn_number: int):
	turn_number_label.text = "Turn %d" % turn_number
	end_turn.button_pressed = false
func set_up(player : PlayerController):
	player_controller = player
	select_td_menu.player_controller = player
	build_td_menu.player_controller = player
	change_good_menu.player_controller = player



func _on_build_td_pressed() -> void:
	player_controller.on_build_td(player_controller)


func _on_end_turn_toggled(toggled_on: bool) -> void:
	player_controller.turn_manager.player_end_turn(player_controller, toggled_on)
 # Replace with function body.

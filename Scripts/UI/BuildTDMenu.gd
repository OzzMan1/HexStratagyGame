extends Node

var player_controller : PlayerController

@onready var re_button: Button = $RE_button
@onready var i_button: Button = $I_button
@onready var t_button: Button = $T_button
@onready var road_button: Button = $Road_button

@onready var menu: Control = $".."
var button_list = []

func _ready():
	button_list = [re_button, i_button, t_button,road_button]
	player_controller = menu.player_controller
func toggle_of_all_buttons_except(exception_button : Button = null):
	for button in button_list:
		if button != exception_button:
			button.button_pressed = false
		
	
func _on_re_button_toggled(toggled_on: bool) -> void:
	toggle_of_all_buttons_except(re_button)
	if toggled_on:
		player_controller.player_data.build_obj = RE_build.new(player_controller)
	else:
		player_controller.player_data.build_obj = null
		player_controller.overlay_ui.clear_overlay_maps(player_controller)
 # Replace with function body.


func _on_i_button_toggled(toggled_on: bool) -> void:
	toggle_of_all_buttons_except(i_button)
	if toggled_on:
		menu.player_controller.player_data.build_obj = IndustrialBuild.new(player_controller)
		
	else:
		player_controller.player_data.build_obj = null
		menu.player_controller.overlay_ui.clear_overlay_maps(player_controller) # Replace with function body.


func _on_t_button_toggled(toggled_on: bool) -> void:
	
	toggle_of_all_buttons_except(t_button)
	if toggled_on:
		player_controller.player_data.build_obj = Trade.new()
	else:
		player_controller.player_data.build_obj = null
		player_controller.overlay_ui.clear_overlay_maps(player_controller) # Replace with function body. # Replace with function body.

func _on_road_button_toggled(toggled_on: bool) -> void:
	toggle_of_all_buttons_except(road_button)
	if toggled_on:
		player_controller.player_data.build_obj = RoadBuild.new(player_controller)
	else:
		player_controller.player_data.build_obj = null
		player_controller.overlay_ui.clear_overlay_maps(player_controller) # Replace with function body. # Replace with function body.
 # Replace with function body.

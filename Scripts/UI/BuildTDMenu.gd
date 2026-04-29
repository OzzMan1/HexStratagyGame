extends Node

var player_controller : PlayerController

@onready var re_button: Button = $RE_button
@onready var i_button: Button = $I_button
@onready var t_button: Button = $T_button
@onready var road_button: Button = $Road_button


var button_list = []

func _ready():
	button_list = [re_button, i_button, t_button,road_button]

func toggle_of_all_buttons_except(exception_button : Button = null):
	for button in button_list:
		if button != exception_button:
			button.button_pressed = false
		
	
func _on_re_button_toggled(toggled_on: bool) -> void:
	toggle_of_all_buttons_except(re_button)
	print("here")
	if toggled_on:
		# toggle off all other buttons
		
		var tiles = player_controller.build_td.find_resource_improvements(player_controller)
		player_controller.overlay_map.RE_overlay(tiles)
		player_controller.player_data.build_obj = ResourceExtraction.new()
		
	else:
		player_controller.overlay_map.clear_overlay_maps()
 # Replace with function body.


func _on_i_button_toggled(toggled_on: bool) -> void:
	toggle_of_all_buttons_except(i_button)
	if toggled_on:
		player_controller.player_data.build_obj = Industrial.new()
	else:
		player_controller.overlay_map.clear_overlay_maps() # Replace with function body.


func _on_t_button_toggled(toggled_on: bool) -> void:
	
	toggle_of_all_buttons_except(t_button)
	if toggled_on:
		player_controller.player_data.build_obj = Trade.new()
	else:
		player_controller.overlay_map.clear_overlay_maps() # Replace with function body. # Replace with function body.

func _on_road_button_toggled(toggled_on: bool) -> void:
	toggle_of_all_buttons_except(road_button)
	if toggled_on:
		player_controller.player_data.build_obj = Road.new()
	else:
		player_controller.overlay_map.clear_overlay_maps() # Replace with function body. # Replace with function body.
 # Replace with function body.

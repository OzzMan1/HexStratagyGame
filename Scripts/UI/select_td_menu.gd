extends Node

@onready var td_connection_button: Button = $td_connection_button

@onready var label: Label = $GoodsProduced

@onready var td_connections: Node2D = %td_connections

var player_controller : PlayerController
@onready var overlay_ui: Node2D = %OverlayUI

# pass in information about TD 
# forward that to TD connections

func update_good_produced_ui(good : Good, amount : int ):
	if good == null: 
		label.text = "No goods produced" 
	else:
		label.text = "Producing %d %d" % [amount, good.name]


func _on_td_connection_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		td_connections.get_all_possible_td_connections(player_controller)
	else: 
		overlay_ui.clear_overlay_maps() 

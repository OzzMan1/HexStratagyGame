extends Node


# buttons
@onready var td_connection_button: Button = $td_connection_button
@onready var change_good_button: Button = $change_good_button
@onready var expand_td_button: Button = $expand_td_button
@onready var build_unit_button: Button = $build_unit_button

# labels
@onready var good_produced_label: Label = $GoodsProduced
@onready var td_connection: Label = $TD_connection

@onready var overlay_ui: Node2D = %OverlayUI
@onready var player_controller: PlayerController = %PlayerController

# menus 
@onready var change_good_menu: Control = %ChangeGoodMenu

var button_label_list = []



signal interaction_started(interaction : Interaction, player : PlayerController)
signal interaction_stoped(player : PlayerController)

func _ready() -> void:
	button_label_list = [td_connection_button,change_good_button,expand_td_button,
build_unit_button,good_produced_label,td_connection]

func toggle_connection_button():
	td_connection_button.button_pressed = false 

func set_up_menu(td_obj : TileDevelopment):
	for item in button_label_list:
		item.visible = true
	
	td_obj.set_up_select_menu(self)
	
func update_good_produced_ui(good : Good, amount : int ):
	if good == null: 
		good_produced_label.text = "No goods produced" 
	else:
		good_produced_label.text = "Producing %d %s" % [amount, good.name]


func _on_td_connection_button_toggled(toggled_on: bool) -> void:

	if toggled_on:
		emit_signal("interaction_started", td_connection_interaction.new(),player_controller)
	else: 
		# Future 
		# Call interaction stopped -> go to previous state
		overlay_ui.clear_overlay_maps() 
		


func _on_change_good_button_pressed() -> void:
	if change_good_menu.visible == false: 
		change_good_menu.visible = true # Replace with function body.
	else: 
		change_good_menu.visible = false
 # Replace with function body.


func _on_build_unit_button_pressed() -> void:
	player_controller.on_build_unit(player_controller) # Replace with function body.

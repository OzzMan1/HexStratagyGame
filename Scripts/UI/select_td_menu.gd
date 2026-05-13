extends Node


# buttons
@onready var td_connection_button: Button = $td_connection_button
@onready var change_good_button: Button = $change_good_button
@onready var expand_td_button: Button = $expand_td_button

# labels
@onready var good_produced_label: Label = $GoodsProduced
@onready var td_connection: Label = $TD_connection

@onready var overlay_ui: Node2D = %OverlayUI
@onready var player_controller: PlayerController = %PlayerController

# menus 
@onready var change_good_menu: Control = %ChangeGoodMenu


signal interaction_started(interaction : Interaction, player : PlayerController)
signal interaction_stoped(player : PlayerController)


func toggle_connection_button():
	td_connection_button.button_pressed = false 

func set_up_menu(td_obj : TileDevelopment):
	td_connection_button.visible = true 

	change_good_button.visible = true 
	expand_td_button.visible = true 
	good_produced_label.visible = true 
	
	if td_obj is Industrial: 
		pass
	elif td_obj is ResourceExtraction:
		change_good_button.visible = false 
	elif td_obj is Trade:
		change_good_button.visible = false 
		good_produced_label.visible = false 
	elif td_obj is City:
		change_good_button.visible = false 
		good_produced_label.visible = false 			 
		expand_td_button.visible = false
		good_produced_label.visible = false 
		td_connection_button.visible = false 
		td_connection.visible = false

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

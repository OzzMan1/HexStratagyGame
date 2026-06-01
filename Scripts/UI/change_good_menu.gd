extends Node
var matches = []

@onready var items : Array = $ScrollContainer/items.get_children()
var player_controller: PlayerController

@onready var menu: Control = $".."

func _ready() -> void:
	player_controller = menu.player_controller

func _on_search_bar_text_changed(new_text: String):
	matches.clear()

	if new_text == "":
		for i in items: 
			i.show()
		return 
	for i in items: 
		if new_text in i.text:
			matches.append(i)
	for i in items:
		if i in matches:
			i.show()
		else:
			i.hide()
			
# On button presses for goods 
func _on_tool_pressed() -> void:
	# update selected td to tool good 
	player_controller.td_economy.update_good_produced(player_controller, GoodsDatabase.tool)


func _on_iron_ingot_pressed() -> void:
	player_controller.td_economy.update_good_produced(player_controller, GoodsDatabase.iron_ingot) # Replace with function body.

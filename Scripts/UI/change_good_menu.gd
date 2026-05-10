extends Node
var matches = []
@onready var items : Array = $ScrollContainer/items.get_children()

@onready var player_controller: PlayerController = %PlayerController

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
	player_controller.td_system.update_good_produced(player_controller.player_data.selected_td, GoodsDatabase.tool)


func _on_iron_ingot_pressed() -> void:
	player_controller.td_system.update_good_produced(player_controller.player_data.selected_td, GoodsDatabase.iron_ingot) # Replace with function body.

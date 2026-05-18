extends Node
@onready var archer_button: Button = $unit_buttons/archer_button


@onready var menu: Control = $".."


func _on_archer_button_pressed() -> void:
	menu.player_controller.player_data.build_obj = UnitBuild.new(menu.player_controller)
	menu.player_controller.build_system.build_obj_set(menu.player_controller.player_data.build_obj)
	

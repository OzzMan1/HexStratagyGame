extends Node


# Unit info
var target_to_unit : Dictionary[Vector2i, Unit]
@export var archer_scene: PackedScene


var has_ended_turn : bool = false

# For cycling objects
var last_clicked_pos : Vector2i
var last_clicked_index : int

# currnet build object 
var current_menu
var build_obj : Buildable

# selecting tile developments
var selected_td : TileDevelopment
var selected_td_pos : Vector2i


# resources


var resources_amount = {
	"stone" : 500,
	"timber": 500,
}

func get_archer_scene():
	return 	archer_scene

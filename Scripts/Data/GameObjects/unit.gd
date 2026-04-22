extends Selectable

class_name Unit

@onready var sprite2d : Sprite2D = $Sprite2D

var health = 5
@export var initiative : int

@export var unit_name : String 
@export var number_of_moves = 2
var current_num_of_moves = number_of_moves
var tile_pos : Vector2i


var current_path : Array
var current_path_in_range : Array
var current_pos : Vector2i

func on_select(player_controller,selected_pos):
	player_controller.unit_selection.select_unit(player_controller,selected_pos)
	
func deselect(player_controller):
	player_controller.unit_movemement_overlay.clear_overlay_maps()
	
func update_current_number_of_moves(number_of_moves_used : int):
	current_num_of_moves = current_num_of_moves - number_of_moves_used
	
func reset_alpha_value():
	sprite2d.self_modulate.a = 1

func set_alpha_value():
	sprite2d.self_modulate.a = 0.5
	
	
func get_new_pos():
	return current_path_in_range[0]

func get_current_pos():
	return current_pos

func action(other_pos : TerrainData, terrain_pos : Vector2i ):
	# action could be move or attack 
	
	print("This unit at: ", tile_pos, " Other pos is at ", other_pos.name, " ", terrain_pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

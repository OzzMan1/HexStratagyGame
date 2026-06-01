extends Node2D 

class_name Unit

@onready var sprite2d : Sprite2D = $Sprite2D
@export var unit_name : String 
@export var number_of_moves : int = 2
@export var max_health: int = 4
@export var dmg_x: float = 0.4

@onready var health_bar: ProgressBar = $health_bar

var tile_pos : Vector2i
var current_path : Array
var current_path_in_range : Array
var current_pos : Vector2i

var tiles_in_range 
var prev_list 


# UNIT STATS
var current_moves = number_of_moves
var health = max_health 
var damage = health * dmg_x 


func on_select(player_controller,selected_pos):
	player_controller.unit_selection.select_unit(player_controller,selected_pos)
	
func deselect(player_controller):
	player_controller.overlay_ui.clear_overlay_maps(player_controller)

	
func update_current_number_of_moves(number_of_moves_used : int):
	if current_moves - number_of_moves_used >= 0:
		current_moves = current_moves - number_of_moves_used
	else:
		current_moves = 0
func reset_alpha_value():
	sprite2d.self_modulate.a = 1

func set_alpha_value():
	sprite2d.self_modulate.a = 0.5
	
func get_new_pos():
	return current_path_in_range[0]

func get_current_pos():
	return current_pos

func set_health_bar() -> void: 
	health_bar.value = health


func update_health(new_health) -> void: 
	health = new_health
	set_health_bar()


func action(other_pos : TerrainData, terrain_pos : Vector2i ):
	# action could be move or attack 
	
	print("This unit at: ", tile_pos, " Other pos is at ", other_pos.name, " ", terrain_pos)

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

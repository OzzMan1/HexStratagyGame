extends Node2D

class_name PlayerController 

@onready var grid_manager: Node2D = %GridManager
@onready var unit_movement = %UnitMovement
@onready var unit_selection = %SelectionSystem
@onready var unit_movemement_overlay = %UnitMovementOverlay
@onready var unit_manager = %UnitManager
@onready var player_data = $PlayerData
@onready var player_manager: Node2D = $".."

@export var player_id : int

var isActive : bool = false


func oddr_to_axial(hex: Vector2i):
	var q = hex.x - (hex.y - (hex.y & 1)) /2 
	var r = hex.y
	return Vector2i(q,r)

func axial_to_oddr(hex: Vector2i) -> Vector2i:
	var col = hex.x + (hex.y - (hex.y & 1)) / 2
	var row = hex.y
	return Vector2i(col, row)
#

##### HELPER FUNCTIONS ################################
func return_mouse_pos():
	return grid_manager.get_tile_pos(get_local_mouse_position())


############# STATE MANAGEMENT #########################


var state : State = IdleState.new()
func set_state(new_state : State):
	if state:
		state.exit(self)
	state = new_state
	if state:
		state.enter(self)


			
		

func _input(event):
	
	if event.is_action_pressed("player1"):
		print("test1")
		player_manager.set_player(0)
	elif event.is_action_pressed("player2"):
		print("test2")
		player_manager.set_player(1)
	if not isActive:
			return
	state.handle_input(self, event)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

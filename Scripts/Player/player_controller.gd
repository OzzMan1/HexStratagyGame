extends Node2D

class_name PlayerController 

@onready var grid_manager: Node2D = %GridManager
@onready var selection_system = %SelectionSystem
@onready var tile_developement_manager: Node2D = $"../../DataManagers/TileDevelopementManager"

#Player
@onready var player_data = $PlayerData
@onready var player_manager: Node2D = $".."
# Units
@onready var unit_manager = %UnitManager
@onready var unit_movement = %UnitMovement

## TDSystems 
@onready var build_td: Node2D = $"../../GameSystems/TileDevelopmentSystems/build_td"
@onready var create_road: Node2D = %create_road

#UI
@onready var build_td_menu: VBoxContainer = $"../../Canvas/menu/HBoxContainer/BuildTDMenu"

#Display
@onready var overlay_map = %OverlayUI
@onready var tile_development_map: Node2D = %TileDevelopmentUI
@onready var road_display: Node2D = %RoadDisplay


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
	
	if event.is_action_pressed("1"):
		print("test1")
		player_manager.set_player(0)
	elif event.is_action_pressed("2"):
		print("test2")
		player_manager.set_player(1)
	elif event.is_action_pressed("end_turn"):
		# turn manager end turn 
		set_state(IdleState.new())
	if not isActive:
			return
	state.handle_input(self, event)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

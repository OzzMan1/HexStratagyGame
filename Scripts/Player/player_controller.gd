extends Node2D

class_name PlayerController 


#DATA 
@onready var grid_manager: Node2D = %GridManager
@onready var tile_developement_manager: Node2D = $"../../DataManagers/TileDevelopementManager"

@onready var selection_system = %SelectionSystem


#Player
@onready var player_data = $PlayerData
@onready var player_manager: Node2D = $".."
# Units
@onready var unit_manager = %UnitManager
@onready var unit_movement = %UnitMovement



## TDSystems 
@onready var build_td: Node2D = %build_td
@onready var create_road: Node2D = %create_road
@onready var select_td: Node2D = %select_td
@onready var td_connections: Node2D = %td_connections
@onready var td_system: Node2D = %td_system

@onready var dependency_graph: Node2D = %Dependency_graph


#UI
@onready var build_td_menu: VBoxContainer = $"../../Canvas/menu/HBoxContainer/BuildTDMenu"
@onready var select_td_menu: VBoxContainer = %SelectTDMenu
@onready var change_good_menu: Control = %ChangeGoodMenu



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
	

##### HELPER FUNCTIONS ################################
func return_mouse_pos():
	return grid_manager.get_tile_pos(get_local_mouse_position())

func check_td_belongs_to_player(pos) -> bool:
	return player_data.all_players_TD.has(pos)

func get_all_ResourceExtractors():
	var re_list = []
	for td in player_data.all_players_TD.values():
		if td is ResourceExtraction:
			re_list.append(td)
	return re_list

############# STATE MANAGEMENT #########################


var state : State = IdleState.new()
func set_state(new_state : State):
	if state:
		#print("exiting state: ", state.state_name, " going to state: ", new_state.state_name )
		state.exit(self)
	state = new_state
	if state:
		state.enter(self)


			
func is_mouse_over_ui() -> bool:
	var control = get_viewport().gui_get_hovered_control()
	
	if control == null:
		return false
	
# Only block if it's an interactive UI element
	return (
		control is Button
		or control is LineEdit
		or control is TextEdit
		or control is OptionButton
	)
	

	
func _input(event):
	
	if event.is_action_pressed("1"):
		print("test1")
		player_manager.set_player(0)
	elif event.is_action_pressed("2"):
		print("test2")
		player_manager.set_player(1)
	elif event.is_action_pressed("end_turn") or event.is_action("escape"):
		# turn manager end turn 
		set_state(IdleState.new())
	
	if not isActive:
			return
	state.handle_input(self, event)


##### SIGNAL RECIEVER ###### 

func on_interaction_started(interaction: Interaction,player):
	if player == self:
		player.set_state(InteractionState.new(interaction))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select_td_menu.interaction_started.connect(on_interaction_started)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

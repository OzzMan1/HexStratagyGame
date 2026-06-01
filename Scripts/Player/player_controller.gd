extends Node2D

class_name PlayerController 


###### GLOBAL 

# DATA
@onready var grid_manager = get_tree().current_scene.find_child("GridManager", true, false)
@onready var tile_developement_manager = get_tree().current_scene.find_child("TileDevelopementManager", true, false)

@onready var overlay_ui: Node2D = get_tree().current_scene.find_child("OverlayUI", true, false)

@onready var selection_system = get_tree().current_scene.find_child("SelectionSystem", true, false)
@onready var turn_manager = get_tree().current_scene.find_child("TurnManager", true, false)

# Player
@onready var player_manager = get_tree().current_scene.find_child("PlayerManager", true, false)

# Units
@onready var unit_manager = get_tree().current_scene.find_child("UnitManager", true, false)
@onready var unit_movement = get_tree().current_scene.find_child("UnitMovement", true, false)
@onready var unit_selection = get_tree().current_scene.find_child("UnitSelection", true, false)

# TDSystems
@onready var create_road = get_tree().current_scene.find_child("create_road", true, false)
@onready var select_td = get_tree().current_scene.find_child("select_td", true, false)
@onready var td_connections = get_tree().current_scene.find_child("td_connections", true, false)
@onready var td_economy = get_tree().current_scene.find_child("td_economy", true, false)
@onready var build_system = get_tree().current_scene.find_child("build_system", true, false)

# Global Systems
@onready var dependency_graph = get_tree().current_scene.find_child("Dependency_graph", true, false)
@onready var path_finder = get_tree().current_scene.find_child("PathFinder", true, false)

# Display Tile Maps 
@onready var tile_development_map = get_tree().current_scene.find_child("TileDevelopmentUI", true, false)
@onready var road_display = get_tree().current_scene.find_child("RoadDisplay", true, false)

###### Player Specific

# Display System
@onready var overlay_map = get_tree().current_scene.find_child("overlay_map", true, false)

# UI
var menu: Control 
var build_td_menu
var select_td_menu 
var change_good_menu 
var city_menu 

# Player
@onready var player_data = $PlayerData

# Network ID 
var player_id : int
var player_name : String 
# players postion in player list
var player_list_index : int 


var city : TileDevelopment = City.new()
var city_pos


var isActive : bool = false


# we need to assign: 
	# ID 
	# city start pos 
	# 
func _ready() -> void:
	#select_td_menu.interaction_started.connect(on_interaction_started)
	city.player = self

	#tile_developement_manager.update_tile_development_list(self, city_pos ,player_data.city)
	tile_developement_manager.update_tile_development_list(
		player_name,
		city_pos,
		city)
	
	EventBus.player_resources_updated.connect(update_player_resources)

	EventBus.player_resources_updated.emit(player_data.resources_amount)

func update_player_resources(player_resources):
	player_data.resources_amount = player_resources
	print("player resoruces changed ", player_resources)
func set_player_ui(player_ui):
	menu = player_ui
	build_td_menu = menu.build_td_menu
	select_td_menu = menu.select_td_menu
	change_good_menu = menu.change_good_menu
	city_menu = menu.city_menu


func set_up(id : int, _player_name: String, _city_pos : Vector2i):
	player_id = id 
	player_name = _player_name 
	
	city_pos = _city_pos

	print("player name ", player_name)
	print("player id ", player_id)
	print("player city pos ", city_pos)
# Called when the node enters the scene tree for the first time.



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
	
	# change to look at TD manager
	return tile_developement_manager.tile_development_list[pos]["name"] == player_name

func get_all_TDs() -> Array:
	var arr = []
	for pos in tile_developement_manager.tile_development_list:
		if tile_developement_manager.tile_development_list[pos]["name"] == player_name:
			arr.append(tile_developement_manager.tile_development_list[pos]["TD"])
	return arr

func get_all_ResourceExtractors():
	var re_list = []
	for td in tile_developement_manager.tile_development_list:
		if td["TD"] is ResourceExtraction:
			re_list.append(td["TD"])
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
	
	if event.is_action_pressed("end_turn") or event.is_action("escape"):
		# turn manager end turn 
		set_state(IdleState.new())
	elif event.is_action_pressed("t"):
		print(player_data.resources_amount)
	elif event.is_action_pressed("1"):
		print("THis is ", NetworkManager.players[multiplayer.get_unique_id()]["name"])

	
	state.handle_input(self, event)


##### SIGNAL RECIEVER ###### 

func on_interaction_started(interaction: Interaction,player):
	if player == self:
		player.set_state(InteractionState.new(interaction))

func on_build_td(player):
	player_data.current_menu = build_td_menu
	if player == self:
		self.set_state(BuildState.new())

func on_build_unit(player):
	player_data.current_menu = city_menu
	if player == self:
		self.set_state(BuildState.new())

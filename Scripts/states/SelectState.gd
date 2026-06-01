extends State

class_name SelectState

var selected_pos : Vector2i
var selected_object 
var state_name : String = "Select"


func _init(pos: Vector2i, _selected_object ) -> void:
	selected_pos = pos
	selected_object = _selected_object
# when we enter select state(just clicked a selectable object, we call that objects select function)
func enter(player_controller) -> void:
	print("entering select state ")
	if selected_object.has_method("on_select"):
		
		selected_object.on_select(player_controller,selected_pos)

func exit(player_controller) -> void:
	print("exit select state")
	if selected_object.has_method("deselect"):
		selected_object.deselect(player_controller)
	
	

func handle_input(player_controller, event) -> void:

	var pos : Vector2i = player_controller.return_mouse_pos()
	if event.is_action_pressed("click"):
		
		if player_controller.is_mouse_over_ui():
			print("click ui")
			return
		var clicked = player_controller.selection_system.get_clicked_object(player_controller,pos)
	
		if clicked != null: 
			player_controller.set_state(SelectState.new(pos,clicked))
		else:
			player_controller.set_state(IdleState.new())
	
	
	elif event.is_action_pressed("Rclick"):
		#var pos = player_controller.return_mouse_pos()
		if selected_object is Unit:
			#player_controller : PlayerController,  selected_unit : Unit, new_pos : Vector2i, previous_pos : Vector2i
			player_controller.unit_movement.set_unit_path(player_controller, selected_object, pos,selected_pos)
		if selected_object is Road:
			player_controller.create_road.create_road_path(player_controller,selected_pos,pos)
			#player_controller.player_data.is_building_road = false
		player_controller.set_state(IdleState.new())

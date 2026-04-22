extends State

class_name SelectState

var selected_pos : Vector2i
var selected_object : Selectable


func _init(pos: Vector2i, _selected_object : Selectable) -> void:
	selected_pos = pos
	selected_object = _selected_object
# when we enter select state(just clicked a selectable object, we call that objects select function)
func enter(player_controller) -> void:
	selected_object.on_select(player_controller,selected_pos)
# when we deselect (exiting the selec)
func exit(player_controller) -> void:
	selected_object.deselect(player_controller)
	
func handle_input(player_controller, event) -> void:

	var pos : Vector2i = player_controller.return_mouse_pos()
	if event.is_action_pressed("click"):

		#var pos = player_controller.return_mouse_pos()
		var clicked = player_controller.unit_selection.get_clicked_object(player_controller,pos)
		if clicked != null: 
			player_controller.set_state(SelectState.new(pos,clicked))
		else:
			player_controller.set_state(IdleState.new())
	
	elif event.is_action_pressed("Rclick"):
		#var pos = player_controller.return_mouse_pos()
		if selected_object is Unit:
			#player_controller : PlayerController,  selected_unit : Unit, new_pos : Vector2i, previous_pos : Vector2i

			player_controller.unit_movement.set_unit_path(player_controller, selected_object, pos,selected_pos)
	# I Rclick IS realased

	elif event.is_action_pressed("undo_movement"):
		if selected_object is Unit:
			# Call undo movement 
			player_controller.unit_movement.undo_unit_path(player_controller,selected_object)

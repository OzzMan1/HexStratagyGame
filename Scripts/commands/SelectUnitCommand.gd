class_name SelectUnitCommand
extends Command

var pos: Vector2

func _init(_pos: Vector2):
	pos = _pos

func execute(player_controller):
	player_controller.select_unit(pos)
	# player_cont

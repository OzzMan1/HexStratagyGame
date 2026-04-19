extends Node

class_name  unit_order

var prev : Vector2i 
var target : Vector2i
var unit : Unit 
var number_of_moves : int

func _init(_prev : Vector2i, _target : Vector2i, _unit : Unit, _number_of_moves : int) -> void: 
	prev = _prev
	target = _target 
	unit = _unit
	number_of_moves = _number_of_moves
	
func _to_string() -> String:
	return "MoveOrder(%s: %s -> %s)" % [unit, prev, target]

extends Node

class_name  unit_order

var prev : Vector2i 
var target : Vector2i
var iniative : int 
var unit : Unit 

func _init(_prev : Vector2i, _target : Vector2i, _iniative : int, _unit : Unit) -> void: 
	prev = _prev
	target = _target 
	iniative = _iniative
	unit = _unit
	
	

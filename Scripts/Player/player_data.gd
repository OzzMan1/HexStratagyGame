extends Node


var unit_list_local = {}

@export var archer_scene: PackedScene

@export var player_name : String 


func get_archer_scene():
	return 	archer_scene

func get_unit_list_local():
	return unit_list_local

func test():
	print(player_name)

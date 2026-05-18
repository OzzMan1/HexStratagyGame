extends Node


signal object_built(build_obj : Buildable)
signal build_obj_selected(build_obj)

func build(player_controller,build_obj):
	if build_obj.can_build() and check_balance(player_controller,build_obj, build_obj.amount):
		
		emit_signal("object_built", build_obj)
		build_obj.confirm_build(player_controller)
		ammend_balance(player_controller, build_obj)

func build_obj_set(build_obj):
	emit_signal("build_obj_selected", build_obj)
	
func check_balance(player_controller,build_obj, amount : int =  1) -> bool:
	for resource in build_obj.resource_cost.keys():
		var players_resources = player_controller.player_data.resources_amount.get(resource) 
		var build_obj_resource_cost = build_obj.resource_cost.get(resource) * amount
		if players_resources < build_obj_resource_cost:
			print("Not enough money")
			return false
	return true
	
func ammend_balance(player_controller,build_obj,amount : int =  1):
		for resource in build_obj.resource_cost.keys():
			var players_resources = player_controller.player_data.resources_amount.get(resource) 
			var build_obj_resource_cost = build_obj.resource_cost.get(resource) * amount
			player_controller.player_data.resources_amount.set(resource, players_resources-build_obj_resource_cost)
		print("how much they have ",player_controller.player_data.resources_amount)

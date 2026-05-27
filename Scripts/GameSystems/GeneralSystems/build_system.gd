extends Node

# This system should handle the logic and decision making of building objects 
# Buildable objects provide the data and speicific implementation while this class coordiantes building the unit 


func build_obj_set(player_controller,build_obj):
	# Call overlay
	if build_obj.create_location_overlay: 
		player_controller.overlay_ui.update_multiple_tiles(player_controller, build_obj.overlay_tiles, 0,build_obj.tile_highlight)

	#emit_signal("build_obj_selected",player_controller, build_obj)

@rpc("any_peer", "call_local", "reliable")
func request_build(player_name : String,player_id: int ,build_obj_name: String ,build_info, player_resources : Dictionary):
	if multiplayer.is_server():
		var build_obj = Register.buildables[build_obj_name].new()
		# Load build_Obj's information back in 
		build_obj.build_info = build_info 
		print("REQUEST BUILD")
		print(build_info)
		if build_obj.can_build() and check_balance(player_resources,build_obj.resource_cost, build_obj.amount):
			start_build.rpc(player_name, build_obj_name, build_info)
		

		if build_info.has("amount"): 
			ammend_balance(player_resources,player_id ,build_obj.resource_cost, build_info["amount"])
		else:
			ammend_balance(player_resources,player_id ,build_obj.resource_cost )


@rpc("any_peer","call_local", "reliable")
func start_build(building_player: String,build_obj_name: String, build_info: Dictionary):
	print("START BUILD")
	var build_obj = Register.buildables[build_obj_name].new()
	build_obj.build_info = build_info 
	build_obj.confirm_build(building_player)

func check_balance(player_resources, build_cost, amount : int =  1) -> bool:
	for resource in build_cost:

		var player_amount = player_resources.get(resource.name)
		var build_obj_resource_cost = build_cost.get(resource) * amount
		if player_amount - build_obj_resource_cost < 0:
			print("Not enough money")
			return false
	return true
	
func ammend_balance(player_resources,player_id ,build_cost, amount : int =  1):
		for resource in build_cost:
			var player_amount = player_resources.get(resource.name) 
			var build_obj_resource_cost = build_cost.get(resource) * amount
			player_resources[resource.name] = player_amount-build_obj_resource_cost


		update_player_resoruces.rpc_id(player_id,player_id,player_resources)
		# UPDATE THIS 
		# 	player_controller.player_data.resources_amount.set(resource, players_resources-build_obj_resource_cost)
		# print("how much they have ",player_controller.player_data.resources_amount)

@rpc("authority","call_local", "reliable")
func update_player_resoruces(player_id,player_resources):
	if multiplayer.get_unique_id() == player_id:
		EventBus.player_resources_updated.emit(player_resources)
		

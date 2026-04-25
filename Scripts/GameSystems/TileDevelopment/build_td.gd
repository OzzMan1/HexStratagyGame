extends Node


func check_balance(player_controller,build_obj) -> bool:
	for resource in build_obj.resource_cost.keys():
		var players_resources = player_controller.player_data.resources_amount.get(resource) 
		var build_obj_resource_cost = build_obj.resource_cost.get(resource)
		if players_resources < build_obj_resource_cost:
			print("Not enough money")
			return false

	return true
	
func ammend_balance(player_controller,build_obj):
		for resource in build_obj.resource_cost.keys():
			var players_resources = player_controller.player_data.resources_amount.get(resource) 
			var build_obj_resource_cost = build_obj.resource_cost.get(resource)
			player_controller.player_data.resources_amount.set(resource, players_resources-build_obj_resource_cost)
		print("how much they have ",player_controller.player_data.resources_amount)

func build_td(player_controller,clicked_tile,build_obj,pos):		
	
	if !player_controller.tile_developement_manager.tile_development_list.has(pos) and check_balance(player_controller,build_obj):
		
		if build_obj is ResourceExtraction:
			build_resource_extraction(player_controller,clicked_tile,build_obj,pos)
		elif build_obj is Industrial or build_obj is Trade:
			build_industiral(player_controller,clicked_tile,build_obj,pos)
		
	# call overlay

func build_resource_extraction(player_controller,clicked_tile,build_obj,pos):
	if clicked_tile is ResourceImprovementData:  
		player_controller.tile_developement_manager.update_tile_development_list(pos,build_obj)
		player_controller.overlay_map.update_tile_developments(pos, clicked_tile.resource_improvment_type,0) 
		ammend_balance(player_controller,build_obj)
	else: 
		print("cant build there")

func build_industiral(player_controller,clicked_tile,build_obj,pos):
	if clicked_tile is TerrainData and clicked_tile is not ResourceImprovementData:
		player_controller.tile_developement_manager.update_tile_development_list(pos,build_obj)
		player_controller.overlay_map.update_tile_developments(pos, build_obj.td_type,0) 
		ammend_balance(player_controller,build_obj)
	else: 
		print("cant build there")


func find_resource_improvements(player_controller):
	var tiles = []
	for tile in player_controller.grid_manager.re_grid.keys():
		tiles.append(tile)
	return tiles

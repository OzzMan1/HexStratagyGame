extends Node



func check_balance(player_controller) -> bool:
	

	return true
	
	
	

func build_td(player_controller,clicked_tile,build_obj,pos):		
	if !player_controller.tile_developement_manager.tile_development_list.has(pos):
		if build_obj is ResourceExtraction:
			build_resource_extraction(player_controller,clicked_tile,build_obj,pos)
		elif build_obj is Industrial or build_obj is Trade:
			build_industiral(player_controller,clicked_tile,build_obj,pos)
	# call overlay

func build_resource_extraction(player_controller,clicked_tile,build_obj,pos):
	if clicked_tile is ResourceImprovementData:  
		player_controller.tile_developement_manager.update_tile_development_list(pos,build_obj)
		player_controller.overlay_map.update_tile_developments(pos, clicked_tile.resource_improvment_type) 

func build_industiral(player_controller,clicked_tile,build_obj,pos):
	if clicked_tile is TerrainData and clicked_tile is not ResourceImprovementData:
		player_controller.tile_developement_manager.update_tile_development_list(pos,build_obj)
		player_controller.overlay_map.update_tile_developments(pos, build_obj.td_type) 



func find_resource_improvements(player_controller):
	var tiles = []
	for tile in player_controller.grid_manager.re_grid.keys():
		tiles.append(tile)
	return tiles

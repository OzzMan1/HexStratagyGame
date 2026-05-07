extends Node


@onready var bfs: Node2D = %BFS
@onready var td_connections: Node2D = %td_connections
@onready var tile_developement_manager: Node2D = %TileDevelopementManager
@onready var overlay_ui: Node2D = %OverlayUI



func check_add_td_to_connections(player_data,pos):
	return player_data.selected_td.possible_td_connections.has(pos) 
	
# we select the tile, it calls select industrial which updates are player information 
# we then select a tile but it breaks on this
func get_all_possible_td_connections(player_controller : PlayerController): 

	var start = player_controller.player_data.selected_td_pos
	var graph = tile_developement_manager.road_list
	var search_criteria = player_controller.player_data.player_tile_to_TD
	var range = player_controller.player_data.selected_td.range

	var td_connection_list = bfs.BFS(player_controller,start,graph,search_criteria,range)

	for pos in td_connection_list:
		# check if pos of td is owned by player
		if player_controller.player_data.player_tile_to_TD.get(pos) is not ResourceExtraction:
			player_controller.player_data.selected_td.possible_td_connections.set(pos, 
			player_controller.player_data.player_tile_to_TD.get(pos))
	
	player_controller.overlay_map.update_td_connection(player_controller.player_data.selected_td.possible_td_connections.keys(),
	player_controller.player_data.selected_td.td_connections.keys())


func add_td_connection(player_controller,pos):
	if check_add_td_to_connections(player_controller.player_data, pos):
		var td_to_add = player_controller.player_data.player_tile_to_TD.get(pos)
		if player_controller.player_data.selected_td.td_connections.has(pos):
			player_controller.player_data.selected_td.td_connections.erase(pos)
		else: 
			player_controller.player_data.selected_td.td_connections.set(pos, td_to_add)
		
		player_controller.overlay_map.update_td_connection(player_controller.player_data.selected_td.possible_td_connections.keys(),
		player_controller.player_data.selected_td.td_connections.keys())
		

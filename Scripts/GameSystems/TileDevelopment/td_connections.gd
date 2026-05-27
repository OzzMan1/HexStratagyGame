extends Node


@onready var bfs: Node2D = %BFS
@onready var td_connections: Node2D = %td_connections
@onready var tile_developement_manager: Node2D = %TileDevelopementManager
@onready var overlay_ui: Node2D = %OverlayUI
@onready var td_economy: Node2D = %td_economy



func check_add_td_to_connections(player_data,pos):
	return player_data.selected_td.possible_td_connections.has(pos) 
# we select the tile, it calls select industrial which updates are player information 
# we then select a tile but it breaks on this
func get_all_possible_td_connections(player_controller : PlayerController): 

	var start = player_controller.player_data.selected_td_pos
	var graph = tile_developement_manager.road_list
	var search_criteria = player_controller.player_data.all_players_TD
	var _range = player_controller.player_data.selected_td.range

	var td_connection_list = bfs.BFS(player_controller,start,graph,search_criteria,_range)

	for pos in td_connection_list:
		# check if pos of td is owned by player
		if player_controller.player_data.all_players_TD.get(pos) is not ResourceExtraction:
			player_controller.player_data.selected_td.possible_td_connections.set(pos, 
			player_controller.player_data.all_players_TD.get(pos))
	
	player_controller.overlay_map.update_td_connection(player_controller.player_data.selected_td.possible_td_connections.keys(),
	player_controller.player_data.selected_td.td_connections.keys())


func add_td_connection(player_controller,pos):
	if check_add_td_to_connections(player_controller.player_data, pos):
		var td_to_add = player_controller.player_data.all_players_TD.get(pos)
	
		if player_controller.player_data.selected_td.td_connections.has(pos):
			# erase from selected td connections
			player_controller.player_data.selected_td.td_connections.erase(pos)
			# erase from td_to_adds incoming list
			if td_to_add is not ResourceExtraction:
				td_to_add.incoming_td_connections.erase(player_controller.player_data.selected_td_pos)
				print( "td to adds list  removing ", td_to_add.incoming_td_connections)
		else: 
			player_controller.player_data.selected_td.td_connections.set(pos, td_to_add)
			# update td_to_adds incoming list if they are not resource extraction
			if td_to_add is not ResourceExtraction:
				td_to_add.incoming_td_connections.set(player_controller.player_data.selected_td_pos,
				 player_controller.player_data.selected_td)
				print( "td to adds list  adding ", td_to_add.incoming_td_connections)
		
		
		# Update economy
		td_economy.update_economy(player_controller)

		# update ui 
		player_controller.overlay_map.update_td_connection(player_controller.player_data.selected_td.possible_td_connections.keys(),
		player_controller.player_data.selected_td.td_connections.keys())
		

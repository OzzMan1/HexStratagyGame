extends Node


@onready var bfs: Node2D = %BFS
@onready var td_connections: Node2D = %td_connections
@onready var tile_developement_manager: Node2D = %TileDevelopementManager
@onready var overlay_ui: Node2D = %OverlayUI


func get_all_possible_td_connections(player_controller : PlayerController): 
	# player_tile_to_TD 
	# road list 
	#func BFS(player_controller : PlayerController, start : Vector2i ,graph : Dictionary, search_criteria : Dictionary = {}, max_range : int = 1000)
	var start = player_controller.player_data.selected_td_pos
	var graph = tile_developement_manager.road_list
	var search_criteria = player_controller.player_data.player_tile_to_TD
	var range = player_controller.player_data.selected_td.range

	var td_connection_list = bfs.BFS(player_controller,start,graph,search_criteria,range)
	overlay_ui.td_connection_overlay(td_connection_list)






# TD connectios - player clicks td button, highlight possible TD's and current TD connections 

# Player clicks td connection button 

# Select state, as this happens while selecting unit  

#  TD System 
#  All possible TD connections 
#  current TD connections 
#  Find all possible TD connections 
# 		pathfinding across combined TD + ROAD graph 

# OVerlay 
# highlight overlayed
	

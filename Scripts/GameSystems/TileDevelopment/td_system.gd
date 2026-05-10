extends Node

@onready var dependency_graph: Node2D = %Dependency_graph

# This system should recacluate the entire economy 
# 1. We need to create a depenedency graph of TD network 
# 2. in order,
# 2.1 calcualte the number of goods the current node is producing 
# 2.2 we look at the the td connection list of each node, and update 
# the receivers incoming goods list

func intialise_economy(TD_list):
	# reset all incoming goods 
	for td in TD_list:
		if td is Industrial or td is Trade:
			td.incoming_goods.clear()
			
func update_economy_from_td(player_controller : PlayerController):
	
	intialise_economy(player_controller.player_data.all_players_TD.values())
	var topological_sort_arr = dependency_graph.topological_sort(player_controller.player_data.all_players_TD )
	
	for td in topological_sort_arr:
		if td is Industrial and td.good_produced != null:
			calculate_goods_produced(td)
		distribute_goods(td)

func distribute_goods(TD : TileDevelopment): 
	var num_recievers = TD.td_connections.values().size()
	if num_recievers > 0:
		var goods_to_add = {TD.good_produced : TD.number_of_good_produced / num_recievers}
		
		for td in TD.td_connections.values():
			add_incoming_goods(goods_to_add, td)


func add_incoming_goods(incoming_goods, receiving_td):
	for good in incoming_goods:
		var amount_to_add = incoming_goods[good]
		if receiving_td.incoming_goods.has(good):
			receiving_td.incoming_goods[good] += amount_to_add
		else:
			receiving_td.incoming_goods[good] = amount_to_add


func update_good_produced(selected_td : TileDevelopment, new_good : Good ):
	selected_td.good_produced = new_good




func calculate_goods_produced(selected_td : TileDevelopment):
	# recipe 
	# expected resources = stockpile + incoming goods
	
	var expected_resources = { }
	
	for good in selected_td.good_produced.input.keys():
		if selected_td.incoming_goods.has(good) and selected_td.good_stockpile.has(good):
			expected_resources.set(good, selected_td.incoming_goods.get(good) + selected_td.good_stockpile.get(good)) 
		else:
			expected_resources.set(good, selected_td.incoming_goods.get(good) )
	
	
	var output = calculate_output(selected_td,expected_resources)
	selected_td.number_of_good_produced = output * selected_td.good_produced.output
		


func calculate_output(selected_td,expected_resources) -> int:
	var min_amount = INF
	for good in selected_td.good_produced.input.keys():
		var available = expected_resources.get(good, 0)
		if available == null:
			return 0 
		var required =  selected_td.good_produced.input.get(good)
		var amount = floor(available / required)

		if amount == 0: 
			return 0 
		elif min_amount > amount:
			min_amount = amount 
	return min_amount
			

extends Node

@onready var dependency_graph: Node2D = %Dependency_graph
@onready var tile_developement_manager = get_tree().current_scene.find_child("TileDevelopementManager", true, false)

func update_good_produced(player_controller : PlayerController, new_good : Good, ):
	
	player_controller.player_data.selected_td.good_produced = new_good
	
	update_economy(player_controller)
	


# Economy loop 
# This is the process to caclulate the current economy 
# needs to calculate: 
	# What each TD recieves
	# What each TD produces 
	# What each TD conusmes 

# This system should recacluate the entire economy 
	# First we wipe the incoming goods 
	# Then we create the topological sort so we know what order to update each node
	# If the node produces goods, then we calculate how many goods it produces
	# Then we distriubte the goods to the TD's that node is connected to 

# Economy 

func update_economy(player_controller : PlayerController):
	


	intialise_economy(player_controller.get_all_TDs())
	var topological_sort_arr = dependency_graph.topological_sort(tile_developement_manager.tile_development_list)
	
	for td in topological_sort_arr:
		# We want to calculate the goods produced only for TDs that are making goods (apart from RE)
		# these are only industrial tiles
		if td is Industrial and td.good_produced != null:
			calculate_goods_produced(td)
		# If a TD is producing goods these need to be distributed
		if td is not City:
			distribute_goods(td)


func intialise_economy(TD_list):
	# reset all incoming goods 
	for td in TD_list:
		if td is Industrial or td is Trade or td is City:
			td.incoming_goods.clear()


## DISTRIBUTE PROCESS			
func distribute_goods(TD : TileDevelopment): 
	var num_recievers = TD.td_connections.values().size()
	# only if they have 
	
	
	if num_recievers > 0:
		var goods_to_add = {TD.good_produced : TD.number_of_good_produced / num_recievers}
		
		
		
		for td in TD.td_connections.values():
			add_incoming_goods(goods_to_add, td)
			#var total_resource_count = 0 
			#for amount in TD.good_stockpile.values():
				#total_resource_count +=  amount 
	#
		


func add_incoming_goods(incoming_goods, receiving_td):
	for good in incoming_goods:
		var amount_to_add = incoming_goods[good]
		print("Goods to add ", amount_to_add)
		if receiving_td.incoming_goods.has(good):
			receiving_td.incoming_goods[good] += amount_to_add
		else:
			receiving_td.incoming_goods[good] = amount_to_add
	
	
	

### CALCULATE PRODUCTION PROCESS


func calculate_goods_produced(selected_td : TileDevelopment):
	# recipe 
	# expected resources = stockpile + incoming goods
	
	# Calculate expected resources
	var expected_resources = { }
	
	for good in selected_td.good_produced.input.keys():
		if selected_td.incoming_goods.has(good) and selected_td.good_stockpile.has(good):
			expected_resources.set(good, selected_td.incoming_goods.get(good) + selected_td.good_stockpile.get(good)) 
		else:
			expected_resources.set(good, selected_td.incoming_goods.get(good) )
	
	# Calculate Output
	var output = calculate_output(selected_td,expected_resources)
	
	#Choose minimum
	if output >= selected_td.expansion_level:
		output = selected_td.expansion_level
	selected_td.number_of_good_produced = output * selected_td.good_produced.output
	
	#Update good balance
	if output > 0: 
		update_good_balance(selected_td,output)

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

func update_good_balance(td : TileDevelopment, output):
# So we consume 10 wood and 10 iron_ingot, 
# Take that away from the stock pile 
	# if a value is negative then we need to dip into the incoming goods

	for good in td.good_produced.input.keys():
		
		# If there are goods in stockpile
		if td.good_stockpile.has(good):
			var remaining = td.good_stockpile.get(good) - (output * td.good_produced.input.get(good))
			if remaining < 0: 
				var curr = td.incoming_good.get(good) 
				td.incoming_good[good] = curr + remaining
				td.good_stockpile[good] = 0
			else:
				td.good_stockpile[good] = remaining	
				print("td good stockpile ", td.good_stockpile, " td incoming good ",td.incoming_good )
		# Otherwise we take from incoming good
		else:
			var remaining = td.incoming_goods.get(good) - (output * td.good_produced.input.get(good))
			td.incoming_goods[good] = remaining
		
		

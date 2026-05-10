extends Node


func topological_sort(graph): 

	var starting_nodes = []
	
	for td in graph.values():
		if td is ResourceExtraction:
			starting_nodes.append(td)
		elif td is Industrial or td is Trade:
			if td.incoming_td_connections.size() == 0:
				starting_nodes.append(td)
	
	var visited = {}
	var topological_sort_arr = []
	for node in starting_nodes:
		DFS(node,visited,topological_sort_arr)
		

	topological_sort_arr.reverse()
	return topological_sort_arr
	
	
func DFS(node, visited, result):
	if visited.has(node):
		return
	visited[node] = true
	for next_node in node.td_connections.values():
		DFS(next_node,visited,result)
		
	result.append(node)
			
		
	

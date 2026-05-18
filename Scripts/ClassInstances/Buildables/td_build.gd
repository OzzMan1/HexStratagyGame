extends Buildable

class_name TDBuild


var tile_map_img 

var build_pos

var clicked_tile


func _init(player_controller) -> void:
	player_controller.build_system.build_obj_set(self)
	
func _on_build(player_controller, pos):
	# Player presses the road button selects start 
	if !player_controller.tile_developement_manager.tile_development_list.has(pos):
		clicked_tile = player_controller.selection_system.get_clicked_object(player_controller,pos)
		build_pos = pos
		player_controller.build_system.build(player_controller,self)


func confirm_build(player_controller):
		
		var build_td = create_td()
		player_controller.tile_developement_manager.update_tile_development_list(player_controller,build_pos,build_td)
		player_controller.tile_development_map.update_tile_development_tile_map(build_pos, tile_map_img) 
		

func create_td():
	pass

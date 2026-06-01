extends Buildable

class_name TDBuild



var tile_map_img 


func _init(player_controller = null) -> void:
	if player_controller != null:
		player_controller.build_system.build_obj_set(player_controller,self)
	
func _on_build(player_controller, pos):
	# if there is no exisiting TD there

	if !player_controller.tile_developement_manager.tile_development_list.has(pos):
		# Update Build info
		build_info["clicked_obj_name"] = player_controller.selection_system.get_clicked_object(player_controller,pos).resource_name
		build_info["build_pos"] = pos


		# Request build to server
		player_controller.build_system.request_build.rpc(
		player_controller.player_name,
		player_controller.player_id,
		self._name,
		build_info,
		player_controller.player_data.resources_amount,)

# RPC
# Player name 
# func on_build_requested(player_name, build_obj._name, build_pos)

func confirm_build(player_name ):
		
		var td = create_td()
		# Update each players TD list 
		# emit signal Tile development manager updated (player_name, build_pos_ build_TD)
		EventBus.TDBuilt.emit(player_name, build_info["build_pos"], td)
		EventBus.TDBuilt_overlay_update.emit(build_info["build_pos"],tile_map_img)

func create_td():
	pass

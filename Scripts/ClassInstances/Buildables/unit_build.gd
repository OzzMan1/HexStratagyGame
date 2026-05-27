extends Buildable

class_name UnitBuild
# Build data 

var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}
var possible_positions

# Overlay Information 
var tile_highlight = Vector2i(0,0)
var create_location_overlay = true 

var _name = "Unit_build"


func _init(player_controller = null) -> void:
	if player_controller != null:
		possible_positions = find_build_pos(player_controller,player_controller.city_pos)
		overlay_tiles = possible_positions
		player_controller.build_system.build_obj_set(player_controller,self)
func _on_build(player_controller, pos):
	# Upade build info
	build_info["build_pos"] = pos
	build_info["possible_positions"] = possible_positions
	build_info["player_index"] = NetworkManager.players[player_controller.player_id]["index"] 
	# Request build to server
	player_controller.build_system.request_build.rpc(
		player_controller.player_name,
		player_controller.player_id,
		self._name,
		build_info,
		player_controller.player_data.resources_amount,)

func confirm_build(player_name):
	EventBus.unit_built.emit(player_name, build_info["player_index"] ,build_info["build_pos"])

func can_build() -> bool:
	if build_info["possible_positions"].has(build_info["build_pos"] ):
		return true
	else: 
		return false 
	 
func find_build_pos(player_controller, city_pos) -> Dictionary:
	var possible_positions_ = {}
	for direction in Directions.ALL:
		var new_pos = city_pos + direction
		if player_controller.grid_manager.terrain_grid.has(new_pos) and !player_controller.player_data.target_to_unit.has(new_pos):
			possible_positions_[new_pos] = true

	return possible_positions_

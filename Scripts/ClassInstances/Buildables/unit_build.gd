extends Buildable

class_name UnitBuild
# Build data 

var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}
var possible_positions
var build_pos

# Overlay Information 
var tile_highlight = Vector2i(0,0)
var create_location_overlay = true 


func _init(player_controller) -> void:
	possible_positions = find_build_pos(player_controller,player_controller.player_data.city_pos)
	overlay_tiles = possible_positions
	player_controller.build_system.build_obj_set(self)
func _on_build(player_controller, pos):
	# Call build System 
	build_pos = pos
	player_controller.build_system.build(player_controller,self)

func confirm_build(player_controller):
	player_controller.unit_manager.create_new_unit(player_controller,build_pos)

func can_build() -> bool:
	if possible_positions.has(build_pos):
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

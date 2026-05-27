extends TDBuild

class_name RE_build


# Overlay Information
var create_location_overlay = true
var tile_highlight = Vector2i(2,0)

var _name = "RE_build"
	
var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}
func _init(player_controller = null) -> void:
	if player_controller != null:
		overlay_tiles = find_resource_improvements(player_controller)
		player_controller.build_system.build_obj_set(player_controller,self)

func create_td():
	
	var td = ResourceExtraction.new()
	tile_map_img = build_info["clicked_obj_name"]
	td.number_of_good_produced = 20 
	match build_info["clicked_obj_name"]:
			"forest":
				td.good_produced = GoodsDatabase.timber 
			"stone":
				td.good_produced = GoodsDatabase.stone 
			"iron":
				td.good_produced = GoodsDatabase.iron_ore  

	return td

func can_build() -> bool:
	#print("IN CAN BUILD")
	#print(build_info)
	if Register.resourceImprovements.has(build_info["clicked_obj_name"]):
		
		if Register.resourceImprovements[build_info["clicked_obj_name"]] is ResourceImprovementData: 
			return true 
	return false

func find_resource_improvements(player_controller):
	
	var tiles = []
	for tile in player_controller.grid_manager.re_grid.keys():
		tiles.append(tile)
	return tiles


		

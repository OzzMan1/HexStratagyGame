extends TDBuild

class_name RE_build


# Overlay Information
var create_location_overlay = true
var tile_highlight = Vector2i(2,0)

	
var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}
func _init(player_controller) -> void:
	overlay_tiles = find_resource_improvements(player_controller)
	player_controller.build_system.build_obj_set(self)

func create_td():
	
	var td = ResourceExtraction.new()
	tile_map_img = clicked_tile.resource_improvment_type
	td.number_of_good_produced = 20 
	match clicked_tile.resource_improvment_type:
			"forest":
				td.good_produced = GoodsDatabase.timber 
			"stone":
				td.good_produced = GoodsDatabase.stone 
			"iron":
				td.good_produced = GoodsDatabase.iron_ore  

	return td

func can_build() -> bool:
	if clicked_tile is ResourceImprovementData:
		return true 
	else: 
		return false  


func find_resource_improvements(player_controller):
	
	var tiles = []
	for tile in player_controller.grid_manager.re_grid.keys():
		tiles.append(tile)
	return tiles


		

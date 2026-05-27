
extends TDBuild

class_name IndustrialBuild 

# Overlay Information
var create_location_overlay = false

var _name = "Industrial_build"


# what resources do you need to build
var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}

func create_td():
	var td =  Industrial.new()
	tile_map_img = td.td_type
	return td


func can_build() -> bool:
	
	if Register.terrain.has(build_info["clicked_obj_name"]):
		var clicked_tile = Register.terrain[build_info["clicked_obj_name"]] 
		if clicked_tile is TerrainData and clicked_tile is not ResourceImprovementData: 
			return true 
	return false
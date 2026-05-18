
extends TDBuild

class_name IndustrialBuild 

# Overlay Information
var create_location_overlay = false

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
	if clicked_tile is TerrainData and clicked_tile is not ResourceImprovementData:
		return true 
	else: 
		return false  

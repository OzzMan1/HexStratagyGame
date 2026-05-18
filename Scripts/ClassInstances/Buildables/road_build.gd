extends Buildable

class_name RoadBuild

# Road data 

var resource_cost = {
	GoodsDatabase.stone: 10,
	GoodsDatabase.timber: 10,
}

# Start and end of roads 
var start : Vector2i
var end : Vector2i

var road_path
var road_display_tiles
var road_has_start = false

# Overlay data
var create_location_overlay = false 



func _init(player_controller) -> void:
	player_controller.build_system.build_obj_set(self)
	
func _on_build(player_controller, pos):
	# Player presses the road button selects start 
	if player_controller.grid_manager.check_bounds(pos):
		if !road_has_start:
			start = pos	
			road_has_start = true
			print("Selected road start")
		else:
			if start == pos:
				print("road has to be longer than one tile")
			else: 
				end = pos
				print("Selected road end")
				var results = player_controller.create_road.create_road_path(player_controller,start,end)
				road_path = results[0]
				road_display_tiles = results[1]
				amount = road_path.size()
				player_controller.build_system.build(player_controller,self)
	 			
		
func can_build() -> bool:
	return true 

func confirm_build(player_controller):
	player_controller.road_display.display_road(road_path,road_display_tiles)
	var road = Road.new()
	for pos in road_path: 
		# Create road section and store pos update tile pos
		player_controller.tile_developement_manager.update_road_list(pos,road)
	player_controller.player_data.build_obj = null
	player_controller.build_td_menu.toggle_of_all_buttons_except()

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


var road_has_start = false

# Overlay data
var create_location_overlay = false 

var _name = "Road_build"



func _init(player_controller = null) -> void:
	if player_controller != null: 
		player_controller.build_system.build_obj_set(player_controller,self)
	
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
		
				build_info["road_path"] = results[0]
				build_info["road_display_tiles"] = results[1]
				build_info["amount"] = build_info["road_path"].size()
				

				player_controller.build_system.request_build.rpc(
				player_controller.player_name,
				player_controller.player_id,
				 _name, 
				build_info, 
				player_controller.player_data.resources_amount)
	 			
		
func can_build() -> bool:
	return true 

func confirm_build(player_name):
	print("road built by ", player_name)
	EventBus.road_dipslay_updated.emit(build_info["road_path"], build_info["road_display_tiles"])
	EventBus.road_built.emit(build_info["road_path"])
	

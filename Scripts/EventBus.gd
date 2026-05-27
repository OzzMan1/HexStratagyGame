extends Node




### BUILDING
# Roads
signal road_dipslay_updated(path, display_tile_coords)
signal road_built(path)
# Units
signal unit_built(player_name,player_index,build_pos )

# Tile Developments
signal TDBuilt(player_name, build_pos, build_TD)
signal TDBuilt_overlay_update(tile, td_image)

# Update Player Resources
signal player_resources_updated(player_resources)


#### COMMANDS 
# Unit
signal unit_moved(player_name, unit, prev, target)

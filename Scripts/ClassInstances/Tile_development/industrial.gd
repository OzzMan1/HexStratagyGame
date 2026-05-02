extends TileDevelopment


class_name Industrial 

var td_type : String = "industrial"

# job informaiton
var number_of_processed_goods_produced : int 
var number_of_goods_consumed : int

# var list of connections

# A Industrial tile ships its goods, to all TD's its connected to 

# TD's can only be connected through a road connection 
# We have road sections, at least two end points 



# what resources do you need to build
var resource_cost = {
	ResourceTypes.Type.STONE: 30,
	ResourceTypes.Type.TIMBER: 40,
}
# for different values it needs to store integers 

func _init() -> void:
	pass

extends Node

class_name ResourceTypes

enum Type {
	STONE,
	TIMBER,
	IRON_ORE
}
#
#func resource_to_string(resource):
	#match resource:
		#ResourceType.STONE:
			#return "Stone"
		#ResourceType.TIMBER:
			#return "Timber"
		#ResourceType.IRON:
			#return "Iron"
	#return "Unknown"

extends Node

@onready var timber: Label = $Wood
@onready var stone: Label = $Stone
@onready var iron: Label = $iron
@onready var iron_ingot: Label = $iron_ingot
@onready var swords: Label = $swords
@onready var tools: Label = $tools

var resource_labels = {

} 

func _ready() -> void:
	EventBus.player_resources_updated.connect(update_player_resources)
	resource_labels = {
		"timber" : timber, 
		"stone" : stone, 
		"iron_ore" : timber,
		"iron_ingot": iron_ingot,
		"swords" : swords, 
		"tools" : tools, 
	} 


func update_player_resources(player_resources):
	for resource in player_resources:
		resource_labels[resource].text = "%s: %d" %  [resource, player_resources[resource]]
		

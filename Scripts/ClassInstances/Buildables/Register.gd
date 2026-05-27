extends Node

class_name Register


# Buildabels 
static var buildables = {
	"RE_build": RE_build,
	"Industrial_build" : IndustrialBuild, 
	"Road_build" : RoadBuild,
	"Unit_build" : UnitBuild,
}

static var resourceImprovements = {
	"forest" : preload("res://Resources/TileImprovements/forest.tres"), 
	"stone" : preload("res://Resources/TileImprovements/stone.tres"),
	"iron" : preload("res://Resources/TileImprovements/iron.tres"),
} 

static var terrain = {
	"plains" : preload("res://Resources/Terrain/plains.tres"),
	"desert" : preload("res://Resources/Terrain/desert.tres"),
	"hill" : preload("res://Resources/Terrain/hill.tres"),
	"water" : preload("res://Resources/Terrain/water.tres"),
	
}

static var unit_1 = preload("res://Scenes/archer_1.tscn")
static var unit_2 = preload("res://Scenes/archer_1.tscn")

static var goods = {
	"timber" : GoodsDatabase.timber,
	"stone" : GoodsDatabase.stone,
	"iron_ore" : GoodsDatabase.iron_ore,
	"tool" : GoodsDatabase.tool,
	"iron_ingot" : GoodsDatabase.iron_ingot,
}

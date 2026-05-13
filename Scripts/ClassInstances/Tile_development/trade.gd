extends TileDevelopment
class_name Trade 

var td_type : String = "trade"
var range : int = 6

var resource_cost = {
	GoodsDatabase.stone: 30,
	GoodsDatabase.timber: 40,
}

func _init() -> void:
	pass


func add_goods_to_stockpile():
	for good in incoming_goods:
		if good_stockpile.has(good):
			good_stockpile[good] += incoming_goods[good]
		else: 
			good_stockpile[good] = incoming_goods[good]

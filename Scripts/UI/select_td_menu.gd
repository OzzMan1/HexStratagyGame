extends Node

@onready var label: Label = $GoodsProduced
func update_good_produced_ui(good : Good, amount : int ):
	if good == null: 
		label.text = "No goods produced" 
	else:
		label.text = "Producing %d %d" % [amount, good.name]

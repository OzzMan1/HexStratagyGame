extends TileDevelopment

class_name ResourceExtraction 

var number_of_raw_goods_produced : int 
var td_type : String = "resource extractor"


var range = 4

# job informaiton
var number_of_good_produced : int = 0
var good_produced : Good  

func set_up_select_menu(menu):
	menu.build_unit_button.visible = false
	menu.change_good_button.visible = false 

		
func update_ui(menu):
	menu.update_good_produced_ui(
		good_produced,
		number_of_good_produced
	)
	

func _init() -> void:
	pass

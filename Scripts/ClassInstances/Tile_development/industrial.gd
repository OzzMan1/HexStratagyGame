extends TileDevelopment

class_name Industrial 

var td_type : String = "industrial"

var expansion_level : int = 1 
var range = 4


# job informaiton
var good_produced : Good  
var number_of_good_produced : int = 0


var capacity : int = 100 



# Incoming goods 

var on_select_buttons = []
	


func set_up_select_menu(menu):
	menu.build_unit_button.visible = false
	


func update_ui(menu):
	menu.update_good_produced_ui(
		good_produced,
		number_of_good_produced
	)




func _init() -> void:
	pass

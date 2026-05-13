extends Node

func update_good_stockpile(td_list):
	for td in td_list.values():
		td.add_goods_to_stockpile()
	
			

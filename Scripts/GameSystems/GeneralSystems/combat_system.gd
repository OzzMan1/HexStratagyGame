extends Node
@onready var unit_manager = %UnitManager


# Combat System, handles combat between units





func start_combat(attacking_player, attacker_path ):
	

	var attacker_current_pos = attacker_path[attacker_path.size()-1]
	var attacker_adjacent_pos = attacker_path[1]
	var target_pos = attacker_path[0]

	# calculate remaining health
	var attacker = unit_manager.unit_list[attacker_current_pos]["Unit"]
	var defender = unit_manager.unit_list[target_pos]["Unit"]

	var attacker_health = attacker.health - defender.damage 
	var defender_health = defender.health - attacker.damage 

	if defender_health <= 0: 
		# attacker moves to target pos 
		defender_dies.rpc(attacking_player, attacker_current_pos,
		 target_pos, attacker_health, attacker_path.size() - 1)
	else: 
		defender_lives.rpc(attacking_player, attacker_current_pos,attacker_adjacent_pos,
			target_pos,attacker_path.size() - 1, attacker_health, defender_health)
		# attacker stays at target_adjacent_pos



@rpc("authority", "call_local", "reliable") 
func defender_lives(attacking_player, attacker_current_pos, 
attacker_adjacent_pos,target_pos,path_size, attacker_health, defender_health):
# Defender lives 
	# Attacker goes to adjacent position 
	# update attacker and defender health
	var attacker = unit_manager.unit_list[attacker_current_pos]["Unit"]
	var defender = unit_manager.unit_list[target_pos]["Unit"]

	EventBus.unit_moved.emit(attacking_player,attacker_current_pos, attacker_adjacent_pos, path_size+1 )
	attacker.update_health(attacker_health) 
	defender.update_health(defender_health) 


@rpc("authority", "call_local", "reliable") 
func defender_dies(attacking_player, attacker_current_pos, 
target_pos, attacker_health, path_size ):
# Defender dies
	# Delete defender
	# Update attackers position 
	# Update attacker health 
	var attacker = unit_manager.unit_list[attacker_current_pos]["Unit"]
	var defender = unit_manager.unit_list[target_pos]["Unit"]
	attacker.update_health(attacker_health) 

	defender.queue_free()
	unit_manager.unit_list.erase(target_pos)
	EventBus.unit_moved.emit(attacking_player,attacker_current_pos, target_pos, path_size+1)

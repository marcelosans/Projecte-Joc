extends Node

signal leveled_up
signal take_damage



var Maxhealth: int = 500
var health: int = Maxhealth
var damage: int = 15

var level = 1 
var exp: int = 0
var requiredExp: int = 50

func get_player_stats():
	return{
		"level": level,
		"health": health,
		"damage": damage,
		"Maxhealth": Maxhealth
	}
	
func add_exp(newExp):
	exp += newExp
	_check_and_do_level_up()
	
func _check_and_do_level_up():
	if exp < requiredExp: return
	
	level += 1
	requiredExp += requiredExp * 1.2
	Maxhealth *= 1.1 
	damage *= 1.1
	
	leveled_up.emit()

func take_enemyDamage(enemyDamage):
	health -= enemyDamage
	take_damage.emit()
	
	

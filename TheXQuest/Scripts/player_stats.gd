extends Node


signal leveled_up
signal take_damage

var maxHealth: int = 100
var health: int = maxHealth
var damage: int = 15



var level = 1 
var exp: int = 0
var requiredExp: int = 50


func get_player_stats():
	return {
		"level" : level,
		"maxhealth": maxHealth,
		"health": health,
		"damage": damage
	}
	
func recibir_daño(damage):
	health -= damage
	health = max(health, 0) 
	
	
	

func add_exp(newExp):
	exp  += newExp
	_check_do_levelup()
	
func _check_do_levelup():
	if exp < requiredExp: return
	
	level +=1
	requiredExp += requiredExp * 1.2
	health *= 1.1
	damage *= 1.1
	leveled_up.emit()

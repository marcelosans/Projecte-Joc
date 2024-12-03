extends CharacterBody2D

var health 
var maxHealth
var damage
var level


func _ready():
	PlayerStats.leveled_up.connect(_update_stats)
	
	_update_stats()
	

func _update_stats():
	var playerStats = PlayerStats.get_player_stats()
	
	level = playerStats["level"]
	maxHealth = ["Maxhealth"]
	health = ["health"]
	damage = ["damage"]
	

	

extends Node2D

var is_player_inside: bool = false



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and is_player_inside:
		PlayerStats.health = PlayerStats.maxHealth




func _on_area_entered(area: Area2D) -> void:
	is_player_inside = true

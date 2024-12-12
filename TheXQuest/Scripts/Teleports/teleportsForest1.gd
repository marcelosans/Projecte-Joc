extends Node2D

func _on_teleport_second_right_body_entered(body: CharacterBody2D) -> void:
	PlayerPosition.spawn_position = Vector2(20, 425)
	PlayerPosition.firstCollisionLayer = false
	PlayerPosition.firstCollisionMask = false
	get_tree().change_scene_to_file("res://Escenas/forest/Forest2.tscn")


func _on_teleport_first_right_body_entered(body: CharacterBody2D) -> void:
	PlayerPosition.spawn_position = Vector2(20, 315)
	PlayerPosition.firstCollisionLayer = true
	PlayerPosition.firstCollisionMask = true
	get_tree().change_scene_to_file("res://Escenas/forest/Forest2.tscn")


func _on_teleport_first_up_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_teleport_first_left_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

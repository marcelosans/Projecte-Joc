extends Node2D

func teleportPlace(x,y, layer, mask, fileName):
	PlayerPosition.spawn_position = Vector2(x, y)
	PlayerPosition.firstCollisionLayer = layer
	PlayerPosition.firstCollisionMask = mask
	get_tree().change_scene_to_file(fileName)

func _on_teleport_first_up_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(311,982,true,true,"res://Escenas/forest/Forest4.tscn");


func _on_teleport_second_up_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(438,486,false,false,"res://Escenas/forest/Forest3.tscn");


func _on_teleport_first_down_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(232,32,true,true,"res://Escenas/forest/Forest3.tscn");


func _on_teleport_second_down_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(481,88,false,false,"res://Escenas/forest/Forest3.tscn");


func _on_teleport_second_right_body_entered(body: Node2D) -> void:
	teleportPlace(23,379,true,true,"res://Escenas/forest/Forest4.tscn");


func _on_teleport_first_left_body_entered(body: Node2D) -> void:
	teleportPlace(487,244,true,true,"res://Escenas/forest/Forest1.tscn");

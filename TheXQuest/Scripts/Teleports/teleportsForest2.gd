extends Node2D

var playerData = PlayerData.new()
var save_file_path = "res://DatosGuardados/"
var save_file_name = "PlayerSave.tres"

func teleportPlace(x,y, layer, mask, fileName):
	PlayerPosition.spawn_position = Vector2(x, y)
	#playerData.UpdatePos(PlayerPosition.spawn_position)
	#playerData.EscenaActual(fileName)
	#ResourceSaver.save(playerData, save_file_path + save_file_name)
	PlayerPosition.firstCollisionLayer = layer
	PlayerPosition.firstCollisionMask = mask
	PlayerPosition.touchedColision=true
	get_tree().change_scene_to_file(fileName)

func _on_teleport_first_up_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(311,982,true,true,"res://Escenas/forest/Forest4.tscn")


func _on_teleport_second_up_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(438,486,false,false,"res://Escenas/forest/Forest3.tscn")


func _on_teleport_first_down_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(232,32,true,true,"res://Escenas/forest/Forest3.tscn")


func _on_teleport_second_down_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(481,88,false,false,"res://Escenas/forest/Forest3.tscn")


func _on_teleport_second_right_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(23,379,false,false,"res://Escenas/forest/Forest4.tscn")


func _on_teleport_second_left_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(489,400,false,false,"res://Escenas/forest/Forest1.tscn")


func _on_teleport_first_left_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(489,243,true,true,"res://Escenas/forest/Forest1.tscn")

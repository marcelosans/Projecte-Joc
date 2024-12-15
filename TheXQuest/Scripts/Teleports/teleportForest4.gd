extends Node2D

var playerData = PlayerData.new()
var save_file_path = "res://DatosGuardados/"
var save_file_name = "PlayerSave.tres"

func teleportPlace(x,y, layer, mask, fileName):
	PlayerPosition.spawn_position = Vector2(x, y)
	playerData.UpdatePos(PlayerPosition.spawn_position)
	playerData.EscenaActual(fileName)
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	PlayerPosition.firstCollisionLayer = layer
	PlayerPosition.firstCollisionMask = mask
	get_tree().change_scene_to_file(fileName)

func _on_teleport_second_left_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(497,369,false,false,"res://Escenas/forest/Forest2.tscn")


func _on_teleport_first_down_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(247,489,true,true,"res://Escenas/forest/Forest2.tscn")


func _on_teleport_end_body_entered(body: CharacterBody2D) -> void:
	get_tree().change_scene_to_file("res://Escenas/GameOver.tscn")

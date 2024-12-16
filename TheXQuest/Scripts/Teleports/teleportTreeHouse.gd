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


func _on_teleport_first_down_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(350,21,false,false,"res://Escenas/forest/Forest3.tscn")

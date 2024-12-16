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
	teleportPlace(246,487,true,true,"res://Escenas/forest/Forest2.tscn")


func _on_teleport_second_up_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(128,486,true,true,"res://Escenas/forest/TreeHouse.tscn")


func _on_teleport_second_right_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(409,488,false,false,"res://Escenas/forest/Forest2.tscn")


func _on_teleport_first_right_body_entered(_body: CharacterBody2D) -> void:
	teleportPlace(26,249,true,true,"res://Escenas/forest/Forest1.tscn")

func _on_teleport_second_down_body_entered(_body: CharacterBody2D) -> void:
	teleportPlace(440,25,true,true,"res://Escenas/forest/Forest2.tscn")


func _on_teleport_first_down_body_entered(_body: CharacterBody2D) -> void:
	teleportPlace(295,25,true,true,"res://Escenas/forest/Forest1.tscn")

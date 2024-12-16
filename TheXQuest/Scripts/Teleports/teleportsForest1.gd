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
	get_tree().change_scene_to_file(fileName)

func _on_teleport_second_right_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(20,425,false,false,"res://Escenas/forest/Forest2.tscn")

func _on_teleport_second_up_body_entered(body: CharacterBody2D) -> void:
	body.position = Vector2(376, 479)

func _on_teleport_first_up_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(328,484,true,true,"res://Escenas/forest/Forest3.tscn")


func _on_teleport_first_left_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(491,200,true,true,"res://Escenas/forest/Forest3.tscn")


func _on_teleport_first_down_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(33,367,true,true,"res://Escenas/forest/Test.tscn")


func _on_teleport_second_down_body_entered(body: CharacterBody2D) -> void:
	body.position = Vector2(438,23)


func _on_teleport_first_right_body_entered(body: CharacterBody2D) -> void:
	teleportPlace(21,296,true,true,"res://Escenas/forest/Forest2.tscn")

extends Area2D

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
	get_tree().change_scene_to_file(playerData.CurrentArea)



func _on_body_entered(_body: Node2D) -> void:
	teleportPlace(216, 486, true, true, "res://Escenas/forest/Forest1.tscn")

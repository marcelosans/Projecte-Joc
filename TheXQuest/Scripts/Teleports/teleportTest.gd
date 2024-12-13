extends Area2D



func teleportPlace(x,y, layer, mask, fileName):
	PlayerPosition.spawn_position = Vector2(x, y)
	PlayerPosition.firstCollisionLayer = layer
	PlayerPosition.firstCollisionMask = mask
	get_tree().change_scene_to_file(fileName)



func _on_body_entered(_body: Node2D) -> void:
	
	teleportPlace(216, 486, true, true, "res://Escenas/forest/Forest1.tscn")

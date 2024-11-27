extends Area2D

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.get_collision_mask_value(1) == true:
		body.set_collision_mask_value(2,true)
		body.set_collision_mask_value(1,false)
	

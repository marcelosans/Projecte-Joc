extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = $Player
	player.position = PlayerPosition.spawn_position
	if (PlayerPosition.firstCollisionLayer != true && PlayerPosition.firstCollisionMask != true):
		player.set_collision_mask_value(2,true)
		player.set_collision_mask_value(1,false)
		player.z_index = 1
	else:
		player.set_collision_mask_value(1,true)
		player.set_collision_mask_value(2,false)
		player.z_index = 0

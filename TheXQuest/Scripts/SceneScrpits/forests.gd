extends Node2D

@onready var sceneTransitionAnimation = $TransicionAnimacion/AnimationPlayer
@onready var MainTrans = $TransicionAnimacion

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioPlayer.play_music_forest(get_tree().current_scene.scene_file_path)
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
	MainTrans.show()
	sceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	sceneTransitionAnimation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	MainTrans.hide()
	

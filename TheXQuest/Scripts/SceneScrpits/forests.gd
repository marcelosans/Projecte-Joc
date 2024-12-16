extends Node2D


@onready var pause_menu = $Player/CanvasLayer/MenuPausa
@onready var sceneTransitionAnimation = $TransicionAnimacion/AnimationPlayer
@onready var MainTrans = $TransicionAnimacion
var paused = false

#Called when the node enters the scene tree for the first time.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		pause_menu.hide()
		get_tree().paused = false
		Engine.time_scale = 1
	else:
		pause_menu.show()
		get_tree().paused = true
		Engine.time_scale = 0
	paused = !paused


func _ready():
	AudioPlayer.play_music_forest(get_tree().current_scene.scene_file_path)
	var player = $Player
	if PlayerPosition.touchedColision==true:
		player.position = PlayerPosition.spawn_position
		PlayerPosition.touchedColision=false
	else:
		player.position = PlayerPosition.player_position

	if (PlayerPosition.firstCollisionLayer != true && PlayerPosition.firstCollisionMask != true):
		player.set_collision_mask_value(2,true)
		player.set_collision_mask_value(1,false)
		player.z_index = 1
	else:
		player.set_collision_mask_value(1,true)
		player.set_collision_mask_value(2,false)
		player.z_index = 0
	PlayerPosition.currentScene=get_tree().current_scene.scene_file_path
	MainTrans.show()
	sceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	sceneTransitionAnimation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	MainTrans.hide()


func _on_teleport_end_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

extends AnimationPlayer

func _ready():
	speed_scale = 0.5
	play("new_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_animation_finished(_anim_name):
	print("Finished")
	play("new_animation")

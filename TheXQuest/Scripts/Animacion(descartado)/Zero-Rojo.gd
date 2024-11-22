extends Sprite2D

@onready var timer: Timer = $Timer

func _ready():
	zoom_out()

func zoom_out():
	var original_scale = scale
	var target_scale = original_scale * 1

	scale = original_scale * 11
	
	# Create a tween and configure it
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", target_scale, 1.7).set_trans(Tween.TransitionType.TRANS_LINEAR).set_ease(Tween.EaseType.EASE_IN_OUT)
	
	# Connect the completion signal for the tween
	tween.finished.connect(_on_tween_completed)

func _on_tween_completed():
	timer.start(0.3)
	# Additional actions can be added here

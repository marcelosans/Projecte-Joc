extends Node2D

func fade_in():
	modulate.a = 0.0
	var tween = get_tree().create_tween()

	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

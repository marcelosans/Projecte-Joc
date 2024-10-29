extends Node2D


onready var tween = $Tween

func fade_in():
	modulate.a = 0.0
	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

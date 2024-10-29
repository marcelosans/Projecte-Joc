extends Sprite

onready var tween = $Tween
onready var second_sprite = $ZeroNegro_Intro
onready var timer = $Timer 

func _ready():
	second_sprite.visible = false
	zoom_out()

func zoom_out():
	var original_scale = scale
	var target_scale = original_scale * 1 
	
	scale = original_scale * 11  
	tween.interpolate_property(self, "scale", scale, target_scale, 1.7, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	tween.connect("tween_completed", self, "_on_tween_completed")

func _on_tween_completed(_obj, _key):
	timer.start(0.3)
	call_other_sprite()

func call_other_sprite():
	second_sprite.visible = true
	second_sprite.zoom_out()

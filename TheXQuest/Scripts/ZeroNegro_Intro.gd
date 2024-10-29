extends Sprite

onready var tween = $Tween
onready var black_rect = $"../../NegroBonito" 
onready var LetrasXinas = $LetrasXinas
onready var timer = $Timer 
onready var Titulo = $Titulo  

func zoom_out():
	var original_scale = scale
	var target_scale = original_scale * 1 

	scale = original_scale * 10 
	tween.interpolate_property(self, "scale", scale, target_scale, 2.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	tween.connect("tween_completed", self, "_on_tween_completed")

func _on_tween_completed(_obj, _key):
	black_rect.visible = true
	timer.connect("timeout", self, "delay_letras_xinas")
	timer.start(0.8) 

func delay_letras_xinas():
	letras_xinas()
	timer.disconnect("timeout", self, "delay_letras_xinas")	

func letras_xinas():
	LetrasXinas.visible = true
	LetrasXinas.fade_in() 
	Titulo.visible = true
	Titulo._ready()

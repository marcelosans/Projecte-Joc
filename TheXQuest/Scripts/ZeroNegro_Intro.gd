extends Sprite2D

@onready var black_rect = $"../../NegroBonito"
@onready var letras_xinas = $LetrasXinas
@onready var luces = $Luces
@onready var timer = $Timer 
@onready var titulo = $Titulo

func zoom_out():
	var original_scale = scale
	var target_scale = original_scale * 1 
	var tween = get_tree().create_tween()

	scale = original_scale * 10 
	tween.tween_property(self, "scale", target_scale, 2.5).set_trans(Tween.TransitionType.TRANS_SINE).set_ease(Tween.EaseType.EASE_IN_OUT)
	
	# Connect the `finished` signal to `_on_tween_completed`
	tween.finished.connect(_on_tween_completed)

func _on_tween_completed():
	black_rect.visible = true
	timer.timeout.connect(delay_letras_xinas)
	timer.start(0.8)

func delay_letras_xinas():
	Animaciones()
	timer.timeout.disconnect(delay_letras_xinas)

func Animaciones():
	letras_xinas.visible = true
	letras_xinas.fade_in()  # Assuming `fade_in()` is a custom function within `LetrasXinas`
	titulo.visible = true
	if titulo.has_method("start_animation"):  # Use specific methods instead of calling `_ready`
		titulo.start_animation()
	luces.visible = true
	if luces.has_method("start_animation"):
		luces.start_animation()

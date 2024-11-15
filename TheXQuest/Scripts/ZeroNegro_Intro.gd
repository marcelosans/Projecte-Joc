extends Sprite2D

@onready var black_rect = "../../NegroBonito"
@onready var letras_xinas = $Timer/LetrasXinas
@onready var luces = $Timer/Luces
@onready var timer = $Timer
@onready var titulo = $Timer/Titulo

var original_scale: Vector2

func _ready():
	original_scale = scale  # Guardamos la escala original al inicio

func zoom_out():
	var target_scale = original_scale * 1
	var tween = get_tree().create_tween()

	# Ampliar la escala inicialmente
	tween.tween_property(self, "scale", target_scale, 2.5).as_relative().set_trans(Tween.TRANS_CUBIC)

	# Conectar la señal de terminado del tween
	tween.finished.connect(_on_tween_completed)

func _on_tween_completed():
	# Hacer visible el rectángulo negro
	black_rect.visible = true

	# Usar un Timer para ejecutar las animaciones con retraso
	timer.start(1.0)  # El temporizador se inicia con un retraso de 1 segundo
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	# Ejecutar las animaciones después del retraso
	letras_xinas.visible = true
	letras_xinas.fade_in()  # Asumimos que `fade_in` es una función personalizada de `LetrasXinas`
	titulo.visible = true
	if titulo.has_method("start_animation"):
		titulo.start_animation()
	luces.visible = true
	if luces.has_method("start_animation"):
		luces.start_animation()

	# Detener el timer para evitar que vuelva a dispararse
	timer.stop()

extends AnimatedSprite2D

# Nueva función para iniciar la animación
func _start_animation():
	# Asegúrate de que el sprite comience transparente y visible
	self.visible = true
	modulate.a = 0.0
	var tween = get_tree().create_tween()

	# Interpolación para hacer el fade-in (de transparente a opaco)
	tween.tween_property(self, "modulate:a", 1.0, 3.0).set_trans(Tween.TransitionType.TRANS_LINEAR).set_ease(Tween.EaseType.EASE_IN_OUT)
	
	# Animación de rotación
	tween.tween_property(self, "rotation", rotation + 12.0 * 3.0, 3.0).set_trans(Tween.TransitionType.TRANS_SINE).set_ease(Tween.EaseType.EASE_IN_OUT)

	# Animación de movimiento (a la derecha)
	var target_position = global_position + Vector2(45.0 * 3.0, 0)
	tween.tween_property(self, "global_position", target_position, 3.0).set_trans(Tween.TransitionType.TRANS_LINEAR).set_ease(Tween.EaseType.EASE_IN_OUT)
	
	# Conectar la señal `finished` del tween al método `_on_tween_completed`
	tween.finished.connect(_on_tween_completed)

# Método que se llama cuando la animación termina
func _on_tween_completed():
	self.visible = false  # Ocultar el sprite al finalizar la animación

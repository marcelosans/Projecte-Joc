extends AnimatedSprite

onready var tween = $Tween

# Nueva función para iniciar la animación
func _start_animation():
	# Asegúrate de que el sprite comience transparente y visible
	self.visible = true
	modulate.a = 0.0
	
	# Interpolación para hacer el fade-in (de transparente a opaco)
	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	# Animación de rotación
	tween.interpolate_property(self, "rotation", rotation, rotation + 12.0 * 3.0, 3.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)

	# Animación de movimiento (a la derecha)
	var target_position = position + Vector2(45.0 * 3.0, 0)
	tween.interpolate_property(self, "position", position, target_position, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	tween.connect("tween_completed", self, "_on_tween_completed")
	self.visible = false

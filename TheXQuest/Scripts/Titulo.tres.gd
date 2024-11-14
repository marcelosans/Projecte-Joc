extends Label

func _ready():
	# Comprobar si el nodo Tween existe y usarlo, si no, crear uno nuevo
	var tween : Tween
	if has_node("Tween"):
		tween = $Tween
	else:
		tween = get_tree().create_tween()
	
	# Animar la propiedad `percent_visible` de 0 a 1.0 en 5 segundos
	tween.tween_property(self, "percent_visible", 1.0, 5.0, Tween.TransitionType.TRANS_CUBIC, Tween.EaseType.EASE_IN)

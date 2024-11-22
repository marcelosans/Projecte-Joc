extends Label

func _ready():
	# Create or get the tween instance
	var tween = Tween if has_node("Tween") else get_tree().create_tween()

	# Animate the percent_visible property
	#tween.tween_property(self, "percent_visible", Vector2(1.0, 5.0), Tween.TransitionType.TRANS_CUBIC, Tween.EaseType.EASE_IN)
	tween.tween_property(self, "visible", true, 5.0).as_relative().set_trans(Tween.TRANS_CUBIC)

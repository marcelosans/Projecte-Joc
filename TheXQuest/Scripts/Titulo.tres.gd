extends Label

func _ready():
	# Create a tween instance if it doesn't exist as a child node
	var tween = $Tween if has_node("Tween") else get_tree().create_tween()

	# Use `tween_property` instead of `interpolate_property`
	tween.tween_property(self, "percent_visible", 1.0, 5.0).set_trans(Tween.TransitionType.TRANS_CUBIC).set_ease(Tween.EaseType.EASE_IN)

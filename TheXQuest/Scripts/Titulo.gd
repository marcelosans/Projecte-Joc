extends Label


func _ready():

	$Tween.interpolate_property(self, "percent_visible", 0.0, 1.0, 5.0, Tween.TRANS_CUBIC, Tween.EASE_IN)	
	$Tween.start()

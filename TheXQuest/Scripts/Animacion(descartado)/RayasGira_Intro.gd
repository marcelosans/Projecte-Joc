extends Sprite2D

# Rotation speed in radians per second
var rotation_speed = 12.0

func _process(delta):
	# Rotate the sprite
	rotation += rotation_speed * delta	

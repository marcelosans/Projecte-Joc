# Manel Pando Fernández

extends Area2D

export var speed = 128# A quina velocitat es mourà el jugador (píxels/seg).
var screen_size #mida finestra joc.
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _animated_sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #obtenir el tamany de la imatge.
	_animated_sprite=get_node("AnimatedSprite")

func _process(delta):
	var velocity = Vector2.ZERO #vector de moviment del jugador.
	if Input.is_action_pressed("move_right"): #Input: detecta input. is_action_pressed: detecta quan es presiona l'acció
		velocity.x += 1 #increment velocitat
		_animated_sprite.play("walk_right")
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		_animated_sprite.play("walk_left")
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
		_animated_sprite.play("walk_front")
	elif Input.is_action_pressed("move_up"):
		velocity.y -= 1
		_animated_sprite.play("walk_back")
	else:
		_animated_sprite.stop()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play() #activa l'animació
		
		
	else:
		$AnimatedSprite.stop() #para l'animació
	
	#posició jugador
	position += velocity * delta
	#restringir al jugador dins del tamany de la pantalla.	
	position.x = clamp(position.x,0, screen_size.x)
	position.y = clamp(position.y,0, screen_size.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

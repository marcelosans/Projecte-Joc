extends Node2D  # O el tipo de nodo que estés usando

var vida: int = 75
var ataque: int = 20
var defensa: int = 5

@onready var sprite = $AnimatedSprite2D  # Asegúrate de que el nodo sprite está nombrado correctamente

func _ready():
	actualizar_label()

func recibir_daño(cantidad: int):
	vida -= cantidad
	vida = max(vida, 0)  # No permitir valores negativos
	actualizar_label()
	
	if vida <= 0:
		sprite.visible = false  # Oculta el sprite
		iniciar_juego()  # Llama a la función para iniciar el juego

func curar(cantidad: int):
	vida += cantidad
	actualizar_label()

func actualizar_label():
	if $mi_label:
		$mi_label.text = "Vida: %d" % vida

func iniciar_juego():
	# Aquí puedes agregar la lógica para comenzar el juego
	print("El juego ha comenzado")  # Reemplaza esto con tu lógica para iniciar el juego

# Combate.gd
extends Control

# Referencia a la escena de enemigo
var enemigo: Enemigo

func _ready():
	# Cargar la escena de enemigo
	var enemigo_scene = preload("res://Escenas/EscenaEnemigo/Enemigo1.tscn")  # Asegúrate de tener la ruta correcta
	enemigo = enemigo_scene.instantiate()
	add_child(enemigo)  # Añadir el enemigo a Combate

	# Posicionar el enemigo en un lugar específico (si es un Node2D)
	if enemigo is Node2D:
		enemigo.position = Vector2(200, 200)  # Posición relativa a la ventana

	# Llamar un método del enemigo
	#enemigo.recibir_daño(10)

func atacar_enemigo():
	if enemigo:
		enemigo.recibir_daño(15)


func _on_btn_fight_pressed() -> void:
	atacar_enemigo()

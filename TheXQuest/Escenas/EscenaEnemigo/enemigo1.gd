extends Node2D

class_name Enemigo

var vida: int = 75
var ataque: int = 20
var defensa: int = 5

func _ready():
	actualizar_label()

func recibir_daño(cantidad: int):
	vida -= cantidad
	vida = max(vida, 0)  # No permitir valores negativos
	actualizar_label()

func curar(cantidad: int):
	vida += cantidad
	actualizar_label()

func actualizar_label():
	if $mi_label:
		$mi_label.text = "Vida: %d" % vida


func _on_btn_fight_pressed() -> void:
	recibir_daño(15)

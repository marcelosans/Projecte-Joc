extends Control

# Importar la clase Enemigo
@onready var Enemigo = preload("res://Escenas/EscenaEnemigo/enemigo1.gd")


var dialogo_visible: bool = false
# Referencia a la escena de enemigo
var enemigo: Node 
@onready var dialogo_timer: Timer = $DialogoTimer  # Asegúrate de tener el Timer en la escena

func _ready():
	var enemigo_scene = preload("res://Escenas/EscenaEnemigo/Enemigo1.tscn")  # Asegúrate de tener la ruta correcta
	enemigo = enemigo_scene.instantiate()
	add_child(enemigo)  # Añadir el enemigo a Combate
	apareceDialogo("Enemigo Salvaje Aparecio")
	# Posicionar el enemigo en un lugar específico (si es un Node2D)
	if enemigo is Node2D:
		enemigo.position = Vector2(800, 300)  # Posición relativa a la ventana
	dialogo_timer.start()  # Iniciar el temporizador para ocultar el diálogo después de un tiempo

func atacar_enemigo():
	if enemigo:
		enemigo.recibir_daño(15)
	if enemigo.vida <= 0:
		get_tree().change_scene_to_file("res://Escenas/Test.tscn")

func apareceDialogo(dialogo : String):    
	$Dialogo.visible = true
	$Dialogo/Label.visible = true
	$Dialogo/Label.text = dialogo
	dialogo_visible = true

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and dialogo_visible == true:
		ocultarDialogo()

# Método para ocultar el diálogo cuando el timer termina o el jugador pulsa
func ocultarDialogo():
	$Dialogo.visible = false
	$Dialogo/Label.visible = false
	dialogo_visible = false
	dialogo_timer.stop()  # Detener el temporizador si el jugador ha interactuado

# Función que maneja la finalización del temporizador
func _on_DialogoTimer_timeout() -> void:
	if dialogo_visible:
		ocultarDialogo()

func _on_btn_fight_pressed() -> void:
	apareceDialogo("Has usado Ataque")
	atacar_enemigo()
	dialogo_timer.start()  # Reiniciar el temporizador

func _on_btn_run_pressed() -> void:
	apareceDialogo("Has huido del combate")
	get_tree().change_scene_to_file("res://Escenas/Test.tscn")
	dialogo_timer.start()  # Reiniciar el temporizador

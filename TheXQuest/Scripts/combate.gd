extends Control

@onready var Enemigo = preload("res://Escenas/EscenaEnemigo/enemigo1.gd")
@onready var dialogo_timer: Timer = $DialogoTimer  # Timer desde la escena

@onready var inventario_vbox = $Inventario/VBoxContainer  # Referencia al VBoxContainer del inventario
 # Recurso que contiene los ítems del inventario

var enemigo: Node

var vidaInicial = Enemigo1.vida

func _ready():
	# Instanciar el enemigo
	Enemigo1._ready()
	PlayerStats.get_player_stats()
	actualizar_label_jugador()
	actualizar_label_enemigo()
	$Jugador/AnimatedSprite2D.play("idle")
	var enemigo_scene = preload("res://Escenas/EscenaEnemigo/Enemigo1.tscn")
	enemigo = enemigo_scene.instantiate()  # Instanciamos el enemigo
	apareceDialogo("¡Un enemigo salvaje apareció!")
	await get_tree().create_timer(2).timeout  # Esperar a que se muestre el diálogo
	ocultarDialogo()

# Función para atacar al enemigo
func atacar_enemigo():
	Enemigo1.recibir_daño(15)
	if Enemigo1.vida <= 0:
		$Enemigo1.visible = false
		apareceDialogo("Has ganado")
		$Jugador/AnimatedSprite2D.play("victory")
		await get_tree().create_timer(2.5).timeout
		PlayerStats.add_exp(Enemigo1.vida/3)
		apareceDialogo("Has ganado" +" "+str(vidaInicial/3)+"exp")
		await get_tree().create_timer(2.5).timeout
		get_tree().change_scene_to_file("res://Escenas/Test.tscn")
	else:
		await get_tree().create_timer(1).timeout  # Esperar un poco antes de la respuesta del enemigo
		enemigo_decision_combate()
		actualizar_label_enemigo()
		actualizar_label_jugador()

# Función para mostrar el diálogo
func apareceDialogo(dialogo: String):
	$Player2/VBoxContainer/btnFight.disabled = true
	$Dialogo.visible = true
	$Dialogo/Label.text = dialogo
	dialogo_timer.start()  # Inicia el temporizador para ocultar el diálogo automáticamente

# Función para ocultar el diálogo
func ocultarDialogo():
	$Dialogo.visible = false
	$Player2/VBoxContainer/btnFight.disabled = false

# Botón de ataque
func _on_btn_fight_pressed() -> void:
	apareceDialogo("Has usado Ataque")
	$Jugador/AnimatedSprite2D.play("attack")
	await get_tree().create_timer(1).timeout  # Esperar a que el diálogo se muestre
	atacar_enemigo()

# Botón de huida
func _on_btn_run_pressed() -> void:
	apareceDialogo("Has huido del combate")
	$Jugador/AnimatedSprite2D.play("runAway")
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Escenas/Test.tscn")

# Método que se llama cuando el temporizador termina
func _on_dialogo_timer_timeout() -> void:
	ocultarDialogo()
	$Jugador/AnimatedSprite2D.play("idle")

func actualizar_label_jugador():
	$HBoxContainer/Player/LabelVidaJugador.text = "Nivel: " + str(PlayerStats.level) + " " + "Jugador 1 " + str(PlayerStats.health) + "/" + str(PlayerStats.maxHealth)
	
func enemigo_decision_combate():
	var opcio = randi() % 3
	var opcio2 = randi() % 100

	
	if (opcio == 1 and Enemigo1.vida < 10):
		apareceDialogo("El enemigo ha usado Curación")
		Enemigo1.curar(10)
	elif (opcio == 2 && opcio2 == 89):
		apareceDialogo("El enemigo ha huido")
		get_tree().change_scene_to_file("res://Escenas/Test.tscn")
	else:
		apareceDialogo("El enemigo ha usado Ataque")
		PlayerStats.recibir_daño(Enemigo1.ataque)
	# Esperar a que el diálogo del enemigo se muestre
	await get_tree().create_timer(1).timeout  # Esperar a que el diálogo se muestre
	ocultarDialogo()  # Ocultar el diálogo del enemigo

func actualizar_label_enemigo():
	$Enemigo1/LabelEnemigo.text = str(Enemigo1.vida)


func _on_btn_item_pressed() -> void:
	apareceDialogo("Avanza en la historia para poder usarlo")

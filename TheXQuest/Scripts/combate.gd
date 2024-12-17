extends Control

@onready var Enemigo = preload("res://Escenas/EscenaEnemigo/enemigo1.gd")
@onready var dialogo_timer: Timer = $DialogoTimer  # Timer desde la escena

@onready var inventario_vbox = $Inventario/VBoxContainer  # Referencia al VBoxContainer del inventario
@export var inventario: Inv  # Recurso que contiene los ítems del inventario

@onready var sceneTransitionAnimation = $TransicionAnimacion/AnimationPlayer
@onready var MainTrans = $TransicionAnimacion

var enemigo: Node

var vidaInicial = Enemigo1.vida

const scene_path = "res://Escenas/combate.tscn"


func _ready():
	
	# Instanciar el enemigo
	var enemigo_scene = preload("res://Escenas/EscenaEnemigo/Enemigo1.tscn")
	
	print(GameState.player_x)
	print(GameState.player_y)
	PlayerStats.get_player_stats()
	actualizar_label_jugador()
	actualizar_label_enemigo()
	get_node("Jugador/AnimatedSprite2D").play("idle")
	enemigo = enemigo_scene.instantiate()  # Instanciamos el enemigo
	Enemigo1._ready()
	
	apareceDialogo("¡Un enemigo salvaje apareció!")
	await get_tree().create_timer(2).timeout  # Esperar a que se muestre el diálogo
	ocultarDialogo()
	
	MainTrans.show()
	sceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	sceneTransitionAnimation.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	MainTrans.hide()
	AudioPlayer.play_music_battle(scene_path)

func _process(delta: float) -> void:
	if get_node("Jugador/AnimatedSprite2D").animation=="idle":
		get_node("Jugador/AnimatedSprite2D").position=Vector2(823,608)
		
	elif get_node("Jugador/AnimatedSprite2D").animation=="attack":
		get_node("Jugador/AnimatedSprite2D").position=Vector2(823,585)
		
	elif get_node("Jugador/AnimatedSprite2D").animation=="runAway":
		get_node("Jugador/AnimatedSprite2D").position=Vector2(823,604)
		
	elif get_node("Jugador/AnimatedSprite2D").animation=="victory":
		get_node("Jugador/AnimatedSprite2D").position=Vector2(823,566)
		
# Función para atacar al enemigo
func atacar_enemigo():
	Enemigo1.recibir_daño(15)
	if Enemigo1.vida <= 0:
		get_node("Enemigo1").visible = false
		apareceDialogo("Has ganado")
		get_node("Jugador/AnimatedSprite2D").play("victory")
		await get_tree().create_timer(2.5).timeout
		PlayerStats.add_exp(Enemigo1.vida/3)
		apareceDialogo("Has ganado" +" "+str(vidaInicial/3)+"exp")
		await get_tree().create_timer(2.5).timeout
		
		MainTrans.show()
		sceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 0
		sceneTransitionAnimation.play("fade_out")
		await get_tree().create_timer(0.5).timeout
		MainTrans.hide()
		
		get_tree().change_scene_to_file(GameState.previous_scene_path)  # Regresa a la escena previa
		 # Restaura la posición
	else:
		await get_tree().create_timer(1).timeout  # Esperar un poco antes de la respuesta del enemigo
		enemigo_decision_combate()
		actualizar_label_enemigo()
		actualizar_label_jugador()

# Función para mostrar el diálogo
func apareceDialogo(dialogo: String):
	get_node("Player2/VBoxContainer/btnFight").disabled = true
	get_node("Dialogo").visible = true
	get_node("Dialogo/Label").text = dialogo
	dialogo_timer.start()  # Inicia el temporizador para ocultar el diálogo automáticamente

# Función para ocultar el diálogo
func ocultarDialogo():
	get_node("Dialogo").visible = false
	get_node("Player2/VBoxContainer/btnFight").disabled = false

# Botón de ataque
func _on_btn_fight_pressed() -> void:
	print("boton presionado")
	apareceDialogo("Has usado Ataque")
	get_node("Jugador/AnimatedSprite2D").play("attack")
	await get_tree().create_timer(1).timeout  # Esperar a que el diálogo se muestre
	atacar_enemigo()

# Botón de huida
func _on_btn_run_pressed() -> void:
	print("boton presionado")
	apareceDialogo("Has huido del combate")
	get_node("Jugador/AnimatedSprite2D").play("runAway")
	await get_tree().create_timer(2).timeout
	
	MainTrans.show()
	sceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 0
	sceneTransitionAnimation.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	MainTrans.hide()
	
	# Regresa a la escena previa
	get_tree().change_scene_to_file(PlayerPosition.currentScene)
	  
	
	
	

# Método que se llama cuando el temporizador termina
func _on_dialogo_timer_timeout() -> void:
	ocultarDialogo()
	get_node("Jugador/AnimatedSprite2D").play("idle")

func actualizar_label_jugador():
	get_node("HBoxContainer/Player/LabelVidaJugador").text = "Nivel: " + str(PlayerStats.level) + " " + "Jugador 1 " + str(PlayerStats.health) + "/" + str(PlayerStats.maxHealth)
	
func enemigo_decision_combate():
	var opcio = randi() % 3
	var opcio2 = randi() % 100

	
	if (opcio == 1 and Enemigo1.vida < 10):
		apareceDialogo("El enemigo ha usado Curación")
		Enemigo1.curar(10)
	elif (opcio == 2 && opcio2 == 89):
		apareceDialogo("El enemigo ha huido")
		get_tree().change_scene_to_file("res://Escenas/forest/Test.tscn")
	else:
		apareceDialogo("El enemigo ha usado Ataque")
		PlayerStats.recibir_daño(Enemigo1.ataque)
		
		

	# Esperar a que el diálogo del enemigo se muestre
	await get_tree().create_timer(1).timeout  # Esperar a que el diálogo se muestre
	ocultarDialogo()  # Ocultar el diálogo del enemigo
	
	if PlayerStats.health <= 0:
		get_tree().change_scene_to_file("res://Escenas/GameOver.tscn")
	

func actualizar_label_enemigo():
	get_node("Enemigo1/LabelEnemigo").text = str(Enemigo1.vida)


func _on_btn_item_pressed() -> void:
	pass # Replace with function body.

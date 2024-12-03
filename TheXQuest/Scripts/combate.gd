extends Control

@onready var Enemigo = preload("res://Escenas/EscenaEnemigo/enemigo1.gd")

@onready var dialogo_timer: Timer = $DialogoTimer  # Timer desde la escena
var dialogo_visible: bool = false
var playerStats = PlayerStats.get_player_stats()
var enemigo: Node

func _ready():
	# Instanciar el enemigo
	PlayerStats.leveled_up.connect(take_enemyDamage)
	$Jugador/AnimatedSprite2D.play("idle")
	var enemigo_scene = preload("res://Escenas/EscenaEnemigo/Enemigo1.tscn")
	enemigo = enemigo_scene.instantiate()
	# Pasar la referencia de la función apareceDialogo al enemigo
	enemigo.set_aparece_dialogo(func(dialogo: String) -> void:
		apareceDialogo(dialogo)
	)
	add_child(enemigo)  # Añadir el enemigo a Combate
	apareceDialogo("¡Un enemigo salvaje apareció!")
	$DialogoTimer.start()
	
	# Posicionar al enemigo (si es Node2D)
	if enemigo is Node2D:
		enemigo.position = Vector2(800, 300)  # Posición relativa a la ventana

func take_enemyDamage():
	playerStats.take_enemyDamage(15)

# Función para atacar al enemigo
func atacar_enemigo():
	if enemigo:
		enemigo.recibir_daño(15)
	if enemigo.vida <= 0:
		get_tree().change_scene_to_file("res://Escenas/Test.tscn")

# Función para mostrar el diálogo
func apareceDialogo(dialogo: String):  
	$Player2/VBoxContainer/btnFight.disabled = true;   
	$Dialogo.visible = true
	$Dialogo/Label.text = dialogo
	dialogo_visible = true
	dialogo_timer.start()  # Inicia el temporizador para ocultar el diálogo automáticamente

# Función para ocultar el diálogo
func ocultarDialogo():
	$Dialogo.visible = false
	dialogo_visible = false
	$Player2/VBoxContainer/btnFight.disabled = false;  

# Botón de ataque
func _on_btn_fight_pressed() -> void:
	apareceDialogo("Has usado Ataque")
	$Jugador/AnimatedSprite2D.play("attack");
	$DialogoTimer.start()
	#$Jugador/AnimatedSprite2D.play("idle")
	atacar_enemigo()
	enemigo.escogeMovimiento()

# Botón de huida
func _on_btn_run_pressed() -> void:
	apareceDialogo("Has huido del combate")
	$DialogoTimer.wait_time = 2
	$DialogoTimer.start()
	$Jugador/AnimatedSprite2D.play("runAway")
	$SalirTImeOut.start()

# Método que se llama cuando el temporizador termina

func _on_dialogo_timer_timeout() -> void:
	ocultarDialogo();
	$Jugador/AnimatedSprite2D.play("idle");


func _on_salir_t_ime_out_timeout() -> void:
	get_tree().change_scene_to_file("res://Escenas/Test.tscn")

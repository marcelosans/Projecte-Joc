extends CharacterBody2D

# Variables para guardar datos
@export var steps_before_encounter: int = 70  # Número promedio de pasos antes de un encuentro
@export var encounter_chance: float = 0.15  # Probabilidad de encuentro por paso extra
@export var encounter_scene_path: String = "res://Escenas/Combate.tscn"  # Ruta de la escena de combate

var save_file_path = "res://DatosGuardados/"
var save_file_name = "PlayerSave.tres"
var save_file_position = "res://DatosGuardados/PlayerPosition.tres"

var is_position_restored: bool = false
var playerData = PlayerData.new()

var playerPos = PlayerPositionCombat.new()

var health = 100
@export var inv: Inv
@export var speed = 100
@onready var animated_sprite = $AnimatedSprite2D

# Variables para los encuentros aleatorios
var steps_taken: int = 0  # Contador de pasos

# Funciones guardar datos
# me quedé aqui mientras pasaba codigo
func _ready():
	verify_save_directory(save_file_path)
	steps_taken = 0
	$AnimatedSprite2D.play("walk_down")
	#if GameState.player_return_position != null:
		#set_global_position(GameState.player_return_position)
	


var area : String = "":
	set(value):
		area = value
		$Label.text = value
	
func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)
	
func load_data():
	var loaded_data = ResourceLoader.load(save_file_path + save_file_name)
	if loaded_data:
		playerData = loaded_data.duplicate(true)
		print("Cargando datos...")
		print("Escena guardada:", playerData.CurrentArea)
		print("Posición guardada:", playerData.SavePos)
		
		# Cambia de escena si es diferente a la actual
		if playerData.CurrentArea != get_tree().current_scene.scene_file_path:
			print("Cambiando a la escena guardada...")
			get_tree().change_scene_to_file(playerData.CurrentArea)
			return
			
		# Guardar las capas y máscaras originales
		
		
		
		# Si estás en la escena correcta, restaura la posición
		#set_physics_process(false)  # Desactiva la física temporalmente
		#collision_layer = 0  # Desactiva todas las capas
		#collision_mask = 0   # Desactiva todas las máscaras  # Desactiva las colisiones del jugador temporalmente
		#self.position = playerData.SavePos  # Asigna la posición guardada
		#await get_tree().process_frame  # Espera un frame para aplicar la posición
		#if playerData.original_collision_layer == 1 and playerData.original_collision_mask == 1:
			#set_collision_layer_value(2,false)
			#set_collision_mask_value(2,false)
			#set_collision_layer_value(playerData.original_collision_layer,true)
			#set_collision_mask_value(playerData.original_collision_mask,true)
		#elif playerData.original_collision_layer == 2 and playerData.original_collision_mask == 2:
			#set_collision_layer_value(1,false)
			#set_collision_mask_value(1,false)
			#set_collision_layer_value(playerData.original_collision_layer,true)
			#set_collision_mask_value(playerData.original_collision_mask,true)
		#self.z_index = playerData.zindex
		#
		#set_physics_process(true)
		#print("Posición restaurada correctamente:", self.position)
	else:
		print("No se encontraron datos guardados")

func on_start_load():
	set_physics_process(false)  # Desactiva la física temporalmente
	self.position = playerData.SavePos
	print("Posición restaurada:", self.position)
	await get_tree().process_frame  # Espera un frame para aplicar la posición
	set_physics_process(true)  # Reactiva la física
	


func save():
	playerData.EscenaActual(get_tree().current_scene.scene_file_path)
	playerData.guardarCapas(collision_mask,collision_layer)
	playerData.zindex = self.z_index 
	print(playerData.CurrentArea)
	playerData.UpdatePos(self.position)
	print(self.position)
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("guardado")
	#escena = get_tree().current_scene.filename 
	
func _process(_delta):
	if not is_position_restored:  # Solo restaura si no se ha hecho antes
		#load_data()
		is_position_restored = true  # Marca como restaurado
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
		
	#if GameState.player_return_position != null:
		#self.set_position(GameState.player_return_position)
		
		#self.global_position = GameState.player_return_position

func handle_step():
	steps_taken += 1

	# Verificar si se supera el número de pasos promedio
	if steps_taken >= steps_before_encounter:
		# Reducir la probabilidad de encuentro con cada paso adicional
		var steps_over = steps_taken - steps_before_encounter
		var adjusted_chance = encounter_chance / (1 + steps_over * 0.1)  # Reduce la probabilidad con cada paso adicional

		var random_chance = randf()  # Número aleatorio entre 0 y 1
		if random_chance < adjusted_chance:
			#save()
			GameState.player_return_position = self.position
			playerData.EscenaActual(get_tree().current_scene.scene_file_path)
			GameState.previous_scene_path = get_tree().current_scene.scene_file_path  # Guarda la ruta de la escena
			trigger_encounter()
			return  # Reinicia los pasos después del encuentro
		else:
			steps_taken = 0  # Reinicia el contador si no hubo encuentro

func trigger_encounter():
	print("¡Encuentro aleatorio!")
	save()
	steps_taken = 0  # Reiniciar contador de pasos
	if encounter_scene_path != "":
		get_tree().change_scene_to_file(encounter_scene_path)

	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	speed = 100
	velocity = input_direction * speed
	if input_direction != Vector2.ZERO:
		handle_step()

func player_sprite_animation():
	if (Input.is_action_pressed("down")):
		animated_sprite.play("walk_down")
	elif (Input.is_action_pressed("up")):
		animated_sprite.play("walk_up")
	elif (Input.is_action_pressed("left")):
		animated_sprite.play("walk_left")
	elif (Input.is_action_pressed("right")):
		animated_sprite.play("walk_right")
	else:
		animated_sprite.stop()
		animated_sprite.frame = 1
		
func _physics_process(_delta):
	if not is_inside_tree():
		return  # No ejecutar si el nodo no está en el árbol de la escena
	get_input()
	player_sprite_animation()
	move_and_slide()

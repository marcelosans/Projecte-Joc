extends CharacterBody2D

# Variables para guardar datos
@export var steps_before_encounter: int = 40  # Número promedio de pasos antes de un encuentro
@export var encounter_chance: float = 0.25  # Probabilidad de encuentro por paso extra
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
	


var area : String = "":
	set(value):
		area = value
		$Label.text = value
	
func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)
	
func load_data():
	playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	on_start_load()
	print("cargado")
	
	
func on_start_load():
	self.position = playerData.SavePos
	print(self.position)
	


func save():
	playerData.UpdatePos(self.position)
	print(self.position)
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("guardado")
	#escena = get_tree().current_scene.filename 
	
func _process(_delta):
	if not is_position_restored:  # Solo restaura si no se ha hecho antes
		load_data()
		is_position_restored = true  # Marca como restaurado
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()

func handle_step():
	steps_taken += 1

	# Verificar si se supera el número de pasos promedio
	if steps_taken >= steps_before_encounter:
		var random_chance = randf()  # Número aleatorio entre 0 y 1
		if random_chance < encounter_chance:
			save()
			GameState.previous_scene_path = get_tree().current_scene.scene_file_path # Guarda la ruta de la escena
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
	get_input()
	player_sprite_animation()
	move_and_slide()

extends CharacterBody2D

# Variables para guardar datos
@export var steps_before_encounter: int = 40  # Número promedio de pasos antes de un encuentro
@export var encounter_chance: float = 0.25  # Probabilidad de encuentro por paso extra
@export var encounter_scene_path: String = "res://Escenas/Combate.tscn"  # Ruta de la escena de combate

var save_file_path = "res://DatosGuardados/"
var save_file_name = "PlayerSave.tres"
var save_file_position = "res://DatosGuardados/PlayerPosition.tres"



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
	# Inicializar inventario si no está configurado
	animated_sprite.play("walk_down")
	


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
	


func save():
	ResourceSaver.save(playerData, save_file_path + save_file_name)
	print("guardado")
	playerData.UpdatePos(self.position)
	escena = get_tree().current_scene.filename 
	
func _process(_delta):
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()

	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

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

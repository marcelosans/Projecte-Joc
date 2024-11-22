extends CharacterBody2D

# Variables guardar datos

var save_file_path = "res://DatosGuardados/"
var save_file_name = "PlayerSave.tres"
var playerData = PlayerData.new()

# Fin variables

var health = 100

@export var speed = 100
@onready var animated_sprite = $AnimatedSprite2D

# Funciones guardar datos

func _ready():
	verify_save_directory(save_file_path)
	
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
	
func _process(_delta):
	if Input.is_action_just_pressed("save"):
		save()
	if Input.is_action_just_pressed("load"):
		load_data()
		
	playerData.UpdatePos(self.position)
	
# Fin funciones

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

extends Control

@onready var start_game_button: Button = $%Iniciar
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content
@onready var Numeros: Control = $ContainerNum
@onready var Info: Control = $ContainerInfoPlayer


#var playerData = PlayerData.new()
#var save_file_path = "res://DatosGuardados/"
#var save_file_name = "PlayerSave.tres"



var contador = 0

func _ready():
	start_game_button.grab_focus()

func quit():
	get_tree().quit()
	
func open_options():
	options_menu.show()
	content.hide()
	Numeros.hide()
	Info.hide()
	options_menu.on_open()
	
func close_options():
	content.show();
	Numeros.show()
	Info.show()
	start_game_button.grab_focus()
	options_menu.hide()

func _on_start_game_button_pressed():
	#playerData.SavePos = Vector2(250, 200)
	#playerData.CurrentArea = "res://Escenas/forest/Test.tscn"
	get_tree().change_scene_to_file("res://Escenas/forest/Test.tscn")
	

extends Control
signal resume

@onready var content: VBoxContainer = $%Container
@onready var options_menu: Control = $%OptionsMenu
@onready var resume_game_button: Button = $%ResumeGame

var player: Node = null

# Guardar la escena actual antes de cambiar al menú de pausa
func open_pause_menu():
	if player and player.has_method("save"):
		player.save()
	
	# Guardar la ruta de la escena actual
	GameState.previous_scene_path = get_tree().current_scene.scene_file_path
	
	# Abrir la escena del menú de pausa
	get_tree().change_scene_to_file("res://Escenas/Menu/MenuPausa.tscn")


func close_pause_menu():
	get_tree().paused = false
	hide()



func _on_resume_game_button_pressed():
	if player and player.has_method("load_data"):
		player.load_data()
	get_tree().change_scene_to_file(GameState.previous_scene_path)  # Regresa a la escena previa


func _on_options_button_pressed():
	content.hide()
	options_menu.show()
	options_menu.on_open()

func _on_options_menu_close():
	options_menu.hide()
	content.show()
	resume_game_button.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_back_to_menu_button_pressed():
	close_pause_menu()
	get_tree().change_scene_to_file("res://Escenas/Menu/MenuInicio.tscn")

func _input(event):
	if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause")) and visible and !options_menu.visible:
		accept_event()
		close_pause_menu()

func _process(_delta):
	if Input.is_action_just_pressed("Escape") and !get_tree().paused:
		open_pause_menu()

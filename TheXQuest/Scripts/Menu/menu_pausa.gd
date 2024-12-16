extends Control


@onready var content: VBoxContainer = $%Container
@onready var options_menu: Control = $%OptionsMenu
@onready var resume_game_button: Button = $%ResumeGame

@onready var main = $"../../../"


var player: Node = null

func open_pause_menu():
	
	get_tree().change_scene_to_file("res://Escenas/Menu/MenuPausa.tscn")

func close_pause_menu():
	get_tree().paused = false
	hide()


func _on_resume_game_button_pressed():
	main.pauseMenu()


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

extends Control
signal start_game_pressed

@onready var start_game_button: Button = $Iniciar
@onready var options_menu: Control = $ContainerBotones/Opciones
@onready var content: Control = $ContainerBotones/Salir 

func _ready():
	start_game_button.grab_focus()

func quit():
	get_tree().quit()
	
func open_options():
	options_menu.show()
	content.hide()
	options_menu.on_open()
	
func close_options():
	content.show();
	start_game_button.grab_focus()
	options_menu.hide()

func _on_start_game_button_pressed():
	emit_signal("start_game_pressed")

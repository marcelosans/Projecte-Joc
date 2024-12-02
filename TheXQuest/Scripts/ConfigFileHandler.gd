extends Node


var config = ConfigFile.new()

const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready():
	
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		#teclasDeMovimiento
		config.set_value("keybinding","left", "A")
		config.set_value("keybinding","left", "Left")
		
		config.set_value("keybinding","up", "W")
		config.set_value("keybinding","up", "Up")
		
		config.set_value("keybinding","down", "S")
		config.set_value("keybinding","left", "Down")
		
		config.set_value("keybinding","right", "D")
		config.set_value("keybinding","right", "Right")
		
		#Guardar si es fullscreen
		
		config.set_value("video","fullscreen", true)
		config.set_value("video","screen_shake", false)

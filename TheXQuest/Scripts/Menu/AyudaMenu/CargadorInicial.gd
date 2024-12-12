extends Node
#Loads options like volume and graphic options on game startup

var config = ConfigFile.new()

# Loads settings from config file. Loads with standard values if settings not 
# existing
func load_settings():
	var err = config.load(OpcionesConstantes.config_file_name)
	
	if err != OK:
		return
	
	var sfx_bus_index = AudioServer.get_bus_index(OpcionesConstantes.sfx_bus_name)
	var music_bus_index = AudioServer.get_bus_index(OpcionesConstantes.music_bus_name)
	var sfx_volume = linear_to_db(config.get_value(OpcionesConstantes.section_name, OpcionesConstantes.sfx_volume_key_name, 1))
	var music_volume = linear_to_db(config.get_value(OpcionesConstantes.section_name, OpcionesConstantes.music_volume_key_name, 1))
	var fullscreen = config.get_value(OpcionesConstantes.section_name, OpcionesConstantes.fullscreen_key_name, false)
	var vsync = config.get_value(OpcionesConstantes.section_name, OpcionesConstantes.vsync_key, true)
	var msaa_2d = config.get_value(OpcionesConstantes.section_name, OpcionesConstantes.msaa_2d_key, 0)
	
	AudioServer.set_bus_volume_db(sfx_bus_index, sfx_volume)
	AudioServer.set_bus_volume_db(music_bus_index, music_volume)
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
	set_msaa("msaa_2d", msaa_2d)
	
func _ready():
	load_settings()

func set_msaa(mode, index):
	match index:
		0:
			get_viewport().set(mode, Viewport.MSAA_DISABLED)
		1:
			get_viewport().set(mode, Viewport.MSAA_2X)
		2:
			get_viewport().set(mode, Viewport.MSAA_4X)
		3:
			get_viewport().set(mode, Viewport.MSAA_8X)

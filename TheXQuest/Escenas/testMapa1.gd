extends Node

# Configuración de probabilidad
var encounter_chance: float = 0.1  # 10% de probabilidad de encuentro
var encounter_delay: float = 1.0    # Tiempo entre encuentros

# Método de verificación de encuentros
func _process(delta):
	if .is_on_ground() and randf() < encounter_chance:
		start_encounter()

# Método para iniciar el encuentro
func start_encounter():
	# Detener el movimiento del jugador
	$Player.stop()
	
	# Aquí puedes cargar la escena del encuentro
	get_tree().change_scene_to_file("res://Escenas/combate.tscn")

	# O puedes instanciar un nodo de encuentro aquí
	# var encounter_scene = preload("res://scenes/Encounter.tscn").instance()
	# add_child(encounter_scene)

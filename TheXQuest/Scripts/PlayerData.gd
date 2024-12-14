extends Resource

class_name PlayerData

@export var speed = 500.0
@export var health = 100
@export var SavePos: Vector2 = Vector2.ZERO
@export var CurrentArea: String = ""  # Ruta de la escena actual


# Función para cambiar la salud
func change_health(value: int):
	health += value

# Actualiza la posición y la escena
func UpdatePos(value: Vector2, current_area: String = ""):
	SavePos = value
	if current_area != "":
		CurrentArea = current_area  # Si la escena es proporcionada, la guardamos

func EscenaActual(value: String):
	CurrentArea = value

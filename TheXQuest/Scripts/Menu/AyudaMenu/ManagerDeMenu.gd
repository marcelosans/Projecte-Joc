extends Node
const OptionConstants = preload("res://Scripts/Menu/AyudaMenu/OpcionesConstantes.gd")
const InputMapUpdater = preload("res://Scripts/Menu/AyudaMenu/ControlesMapa.gd")

@onready var ControllerEchoInputGenerator = $ControladorInputGeneral
@onready var startup_loader = $CargadorInicial

# Called when the node enters the scene tree for the first time.
func _ready():
	InputMapUpdater.new()._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

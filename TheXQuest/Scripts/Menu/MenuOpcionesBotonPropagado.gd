extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	get_popup().connect("window_input", propagate_input)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func propagate_input(event):
	var menu_manager = get_node_or_null("res://Nodes/ManagerDeMenu.tscn")
	if menu_manager and menu_manager.ControllerEchoInputGenerator:
		menu_manager.ControllerEchoInputGenerator._input(event)
	else:
		print("Error: MenuTemplateManager o ControllerEchoInputGenerator no están accesibles.")

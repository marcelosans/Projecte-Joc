extends Control



func _on_retry_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/forest/Test.tscn")


func _on_volver_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Menu/MenuInicio.tscn")


func _on_salir_juego_pressed() -> void:
	get_tree().quit()

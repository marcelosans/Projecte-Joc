extends Area2D

func _on_Encounter_body_entered(body):
	print("entra")
	if body.name == "Player":
		get_parent().get_node("Player").encounter=true


func _on_Encounter_body_exited(body):
	print("sale")
	if body.name == "Player":
		get_parent().get_node("Player").encounter=false

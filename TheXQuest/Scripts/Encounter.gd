extends Area2D

func _on_Encounter_body_entered(body):
	get_parent().get_node("Player").encounter=true


func _on_Encounter_body_exited(body):
	get_parent().get_node("Player").encounter=false

extends Area2D

var can_interact = false

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		$Label.visible = true
		$Label.text = "pulsa [E] para curar todo"
		can_interact = true
		print("Jugador ha entrado en el área")


func _on_body_exited(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		$Label.visible = false
		can_interact = false
		print("Jugador ha salido del área")


func _process(_delta):
	if can_interact and Input.is_action_just_pressed("interact"):
		PlayerStats.health = PlayerStats.maxHealth
		print("Interacción registrada, salud restaurada")

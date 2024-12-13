extends Node


class_name PlayerPositionCombat

@export var SavePos : Vector2 = Vector2.ZERO


func UpdatePosCombat(value: Vector2):
	SavePos = value

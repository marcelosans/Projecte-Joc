extends Node

var spawn_position: Vector2 = Vector2(254,240)
var player_position: Vector2 = Vector2.ZERO

var firstCollisionMask = true
var firstCollisionLayer = true
var touchedColision=true

var currentScene="res://Escenas/forest/Test.tscn"

const FOREST_SCENES = [
	"res://Escenas/forest/Test.tscn",
	"res://Escenas/forest/Forest1.tscn",
	"res://Escenas/forest/Forest2.tscn",
	"res://Escenas/forest/Forest3.tscn",
	"res://Escenas/forest/Forest4.tscn",
	"res://Escenas/forest/TreeHouse.tscn"
]

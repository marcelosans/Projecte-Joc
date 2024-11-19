extends Node

var video_paths = [
	"res://Assets/VideosIntro/Intro1.ogv",
	"res://Assets/VideosIntro/Intro2.ogv",
	"res://Assets/VideosIntro/Intro3.ogv",
	"res://Assets/VideosIntro/Intro4.ogv"
]

@onready var video_player = $Video4
var current_video_index = 0
var has_skipped_to_end = false

func _ready():
	video_player.connect("finished", Callable(self, "_on_video_finished"))
	# Iniciar el primer video
	play_video(current_video_index)

func play_video(index: int):
	if index >= 0 and index < video_paths.size():
		video_player.stream = load(video_paths[index])  # Cargar el video
		video_player.play()  # Reproducir el video


func _on_video_finished():
	current_video_index += 1 
	if current_video_index < video_paths.size():
		play_video(current_video_index)
		
	else:
		print("Secuencia de videos terminada")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			
			if has_skipped_to_end:
				_go_to_menu()
				return
				
			video_player.stop()
			current_video_index = video_paths.size() - 1
			play_video(current_video_index)
			has_skipped_to_end = true

			print("Secuencia de videos saltada al final.")

func _go_to_menu():
	print("Cambiando a la escena del menú...")
	get_tree().change_scene_to_file("res://Escenas/Test.tscn")  

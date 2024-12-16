extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.stop()
	var audioPlayer=$music_end
	audioPlayer.play()
	$AnimatedSprite2D.play()


func _on_music_end_finished() -> void:
	var audioPlayer=$music_end
	audioPlayer.stop()

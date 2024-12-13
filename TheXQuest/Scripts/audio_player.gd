extends AudioStreamPlayer

const forest_music = preload("res://Assets/Musica/SubaruPlea_ForestTheme.wav")
const battle_music = preload("res://Assets/Musica/battleMusic.wav")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_music_forest():
	_play_music(forest_music)
	
func play_music_battle():
	_play_music(battle_music)

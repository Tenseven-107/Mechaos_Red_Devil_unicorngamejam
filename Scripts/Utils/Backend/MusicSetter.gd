extends Node


export (int) var music_theme: int = 0

func _ready():
	MusicPlayer.play_soundtrack(music_theme)

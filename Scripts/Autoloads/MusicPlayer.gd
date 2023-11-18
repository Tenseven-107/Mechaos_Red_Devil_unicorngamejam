extends Node


enum THEMES {
	MAINMENU,
	BUILDING,
	END,
	TOKYO,
	RIO,
	ALASKA,
	AFRICA
}

var TRACKS = {
	THEMES.MAINMENU: [preload("res://SFX/Music/MenuMusic/Fast is fast.wav")],
	THEMES.BUILDING: [preload("res://SFX/Music/MenuMusic/Hot Rod Hot.wav")],
	THEMES.END: [preload("res://SFX/Music/MenuMusic/Panama.wav")],
	THEMES.TOKYO: [preload("res://SFX/Music/StageMusic/Blazing Drift Fever EX.mp3")],
	THEMES.RIO: [preload("res://SFX/Music/StageMusic/Retro_Cyberpunk_2.mp3")],
	THEMES.ALASKA: [preload("res://SFX/Music/StageMusic/3D63 - Analog Hack - 03 Oracles & Miracles.mp3")],
	THEMES.AFRICA: [preload("res://SFX/Music/StageMusic/3D63 - Analog Hack - 02 error cistem terror.mp3")]
}

var current_theme: int = THEMES.MAINMENU
var is_repeating: bool = true

var final_pitch: float = 1

onready var music: AudioStreamPlayer


func _ready():
	var new_player = AudioStreamPlayer.new()
	new_player.bus = "Music"

	music = new_player
	add_child(new_player)


# Play song
func play_soundtrack(theme: int, repeat_themes: bool = true):
	if current_theme != theme or !music.playing:
		is_repeating = false

		music.stop()

		is_repeating = repeat_themes
		current_theme = theme

		var theme_tracks: Array = TRACKS[current_theme]
		if theme_tracks != []:
			music.stream = theme_tracks[randi() % theme_tracks.find(0)]
			music.play()


# Replay song
func replay_theme():
	var theme_tracks: Array = TRACKS[current_theme]
	music.stream = theme_tracks[randi() % theme_tracks.find(0)]
	music.play()


# When the music is finished
func _on_Music_finished():
	if is_repeating:
		replay_theme()

extends Node


# Initialization
signal initialize_hud(hud)
signal set_camera(target)


# Game
signal start_race()
signal end_race()
signal finish_crossed()


# Camera fx
signal camera_shake(new_shake, shake_time, shake_limit)
signal camera_zoom(new_zoom, zoom_time, zoom_limit)
signal hitstop(time)

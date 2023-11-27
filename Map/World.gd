class_name World

extends Node2D

@onready var game_start_play_music:AudioStreamPlayer = $AudioStreamPlayer
@onready var world_scene:TileMap = $World_Scenne
func _ready() -> void:
	#game_start_play_music.play()
	world_scene.visible

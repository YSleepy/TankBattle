class_name MainUi

extends Control

var select_level_scene = preload("res://UI/SelectLevel/SelectLevel.tscn")



func _ready() -> void:
	$AnimationPlayer.play("EnterGameSequence")



func _on_player_button_down() -> void:
	MainManager.GameMode = Manager.GameModeType.Player
	MainManager.PlaySceneTransition()
	await get_tree().create_timer(.7).timeout
	get_tree().change_scene_to_packed(select_level_scene)


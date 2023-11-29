class_name XButton

extends Button


func _on_mouse_entered() -> void:
	var audio = load("res://Tank/sounds/2/statistics_1.ogg")
	$AudioStreamPlayer.set_stream(audio)
	$AudioStreamPlayer.play()



func _on_button_down() -> void:
	var audio_player = AudioStreamPlayer.new()
	audio_player.finished.connect(func():audio_player.queue_free())
	get_tree().get_root().add_child(audio_player)
	var audio = load("res://Tank/sounds/fire.ogg")
	audio_player.set_stream(audio)
	audio_player.play()

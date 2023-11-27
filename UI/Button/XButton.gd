class_name XButton

extends Button


func _on_mouse_entered() -> void:
	var audio = load("res://Tank/sounds/2/statistics_1.ogg")
	$AudioStreamPlayer.set_stream(audio)
	$AudioStreamPlayer.play()



func _on_button_down() -> void:
	var audio = load("res://Tank/sounds/fire.ogg")
	$AudioStreamPlayer.set_stream(audio)
	$AudioStreamPlayer.play()

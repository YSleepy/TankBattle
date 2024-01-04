class_name PlayerHealthUi

extends Control

func update_health(health:int):
	$TextureRect/Health.set_text(str(health))

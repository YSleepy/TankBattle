class_name PlayerFactory
extends Node2D

var res_player = preload("res://Pawn/player.tscn")

func _ready() -> void:
	var instance_player: Player = res_player.instantiate() as Player
	instance_player.position = self.position
	get_parent().add_child.call_deferred(instance_player)

class_name World

extends Node2D

var enemy_nums:int = 8

# Will declear player and enemy spawn position in World
var player_position:Vector2 = Vector2(416/2,416/2)
var enemy_position:Array[Vector2] = [Vector2(50,50),Vector2(150,50),Vector2(250,50)]
# player and enemy position is changeless


var res_enemy_base = preload("res://Pawn/Enemy/EnemyBase.tscn")
var res_player = preload("res://Pawn/player.tscn")

@onready var timer :Timer = $Timer

# player spawn bind Timer
func _ready() -> void:
	var instance_player: Player = res_player.instantiate() as Player
	instance_player.position = Vector2(416/2,416/2)
	add_child(instance_player)
	
	timer.connect("timeout",Callable(self,"spawn_enemy"))
	timer.start()
func spawn_enemy():
	if enemy_nums==0:
		return
	enemy_nums-=1
	if get_tree().get_nodes_in_group("Enemy").size()<5:
		var instance_enemy: EnemyBase = res_enemy_base.instantiate()as EnemyBase
		instance_enemy.position = enemy_position[randi_range(0,2)]
		add_child(instance_enemy)
		timer.wait_time = randf_range(5,8)
		timer.start()

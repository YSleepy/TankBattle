class_name  EnemyFactory
extends Node

enum EnemyType{
	EnemyNormal,
	EnemyFast,
	EnemyHeavy,
	EnemyNormalRed,
	EnemyFastRed,
	EnemyHeavyRed
}

var enemy_nums :int
var largest_exist_num :int
var current_exist_num :int
var scene_array :Array = []


func _ready() -> void:
	scene_array = get_meta("SceneArray")as Array
	enemy_nums = scene_array.size()
	largest_exist_num = get_meta("LargestExistNum")as int
	current_exist_num = 0
	make_enemy()

func make_enemy():
	if enemy_nums>0&&current_exist_num<=largest_exist_num:
		var current_scene:PackedScene = scene_array.pop_back()as PackedScene
		var current_scene_instance:EnemyBase = current_scene.instantiate() as EnemyBase
		current_scene_instance.position = self.position
		current_scene_instance.connect("enemy_killed",Callable(self,"on_enemy_killed_make_enemy"))
		current_exist_num+=1
		get_parent().add_child.call_deferred(current_scene_instance)
	else :
		self.queue_free()

func on_enemy_killed_make_enemy():
	current_exist_num-=1
	make_enemy()

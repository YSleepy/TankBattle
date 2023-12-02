class_name  EnemyFactory
extends Factory

enum EnemyType{
	EnemyNormal,
	EnemyFast,
	EnemyHeavy,
	EnemyNormalRed,
	EnemyFastRed,
	EnemyHeavyRed
}


var enemy_total_num :int
var largest_exist_num :int
var current_exist_num :int
var scene_array :Array = []
var custom_interval:Array = []

func _ready() -> void:
	scene_array = get_meta("SceneArray")as Array
	custom_interval = get_meta("CustomInterval")as Array
	enemy_total_num = get_meta("EnemyTotalNum")as int
	largest_exist_num = get_meta("LargestExistNum")as int
	current_exist_num = 0
	make_enemy()


func make_enemy():
	if enemy_total_num>0&&current_exist_num<largest_exist_num:
		var can_make_num:int = largest_exist_num-current_exist_num
		while can_make_num:
			var random_num:int = randf_range(custom_interval[0],custom_interval[1])
			for i in scene_array:
				var current_scene:Dictionary = i as Dictionary
				if random_num>=current_scene["A"]&&random_num<current_scene["B"]:
					var current_scene_instance:EnemyBase = current_scene["EnemyScene"].instantiate() as EnemyBase
					enemy_total_num-=1
					current_scene_instance.position = self.position
					current_scene_instance.connect("enemy_killed",Callable(self,"on_enemy_killed_make_enemy"))
					current_exist_num+=1
					can_make_num-=1
					get_parent().add_child.call_deferred(current_scene_instance)
					await get_tree().create_timer(1).timeout
	else :
		emit_signal("factory_queue_free",FactoryType.EnemyFactory)
		self.queue_free()

func on_enemy_killed_make_enemy():
	current_exist_num-=1
	make_enemy()

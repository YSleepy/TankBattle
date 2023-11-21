class_name EnemyBase
extends CharacterBody2D

var res_bullet = preload("res://Pawn/Bullet/bullet.tscn")


var health:int
var speed:int
var bullet:int
var facing_direction:Vector2i = Vector2i(0,1)

var can_move:bool = false
var cant_fire:bool = true


@onready var sprite:Sprite2D =$Sprite2D
@onready var spawn_sprite:Sprite2D =$SpawnSprite2D
@onready var spawn_animation =$SpawnAnimation


func _ready() -> void:
	#spawn_animation
	spawn_animation.play("SpawnEnemy")
	

func set_property()->void:
	pass
	

func auto_walk()->void:
	self.velocity.y=200
	move_and_slide()
	
func auto_fire()->void:
		# can instance bullet?
	# 创建子弹实例
	var bullet_instance:Bullet = res_bullet.instantiate() as Bullet
	bullet_instance.connect("bullet_queue_free",Callable(self,"call_deferred_auto_fire"))
	bullet_instance.set_property(Bullet.BulletOwner.Enemy,position,facing_direction)
	# 将子弹添加到场景中
	get_parent().add_child(bullet_instance)
	

'''
这里为什么要延迟1帧调用呢
EnemyBase.gd:41 @ auto_fire():
			Can't change this state while flushing queries. 
			Use call_deferred() or set_deferred() to change monitoring state instead.
  <C++ 错误>       Condition "area->get_space() && flushing_queries" is true.
  <C++ 源文件>      servers/physics_2d/godot_physics_server_2d.cpp:355 @ area_set_shape_disabled()
  <栈追踪>          EnemyBase.gd:41 @ auto_fire()
				 bullet.gd:77 @ attack_Scenne_Border()
				 bullet.gd:118 @ _on_area_2d_body_entered()
直接调用方法去 修改secne_tree (添加、删除子节点)，处理图形碰撞等都会造成线程不安全
理解为锁的问题。不允许查找的时候修改
'''
func call_deferred_auto_fire()->void:
	call_deferred("auto_fire")
	

func killed()->void:
	pass

func _process(delta: float) -> void:
	if can_move:
		auto_walk()


func _on_spawn_animation_animation_finished(anim_name: StringName) -> void:
	spawn_sprite.visible=false
	sprite.visible=true
	can_move = true
	auto_fire()


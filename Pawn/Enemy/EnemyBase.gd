class_name EnemyBase
extends CharacterBody2D

var res_bullet = preload("res://Pawn/Bullet/bullet.tscn")

signal enemy_killed
signal applied_damage(damage:int)

var health:int
var speed:int 
var smallest_per_frame_speed:float
var bullet:int

var facing_direction:Vector2i
var pre_frame_position:Vector2

var can_move:bool = false
var can_fire:bool = false

@onready var sprite:Sprite2D =$Sprite2D
@onready var spawn_sprite:Sprite2D =$SpawnSprite2D
@onready var spawn_animation =$SpawnAnimation
@onready var animation_player =$AnimationPlayer
@onready var timer =$Timer

func _ready() -> void:
	#spawn_animation
	spawn_animation.play("SpawnEnemy")
	facing_direction = get_meta("Direction_Down")as Vector2i
	health = get_meta("Health")as int
	speed = get_meta("Speed")as int
	smallest_per_frame_speed = get_meta("SmallestPerFrameSpeed")
	pre_frame_position = position

func _process(delta: float) -> void:
	if can_move:
		auto_walk(delta)
		update_animation_direction()

func set_property()->void:
	pass
	

func update_animation_direction():
	match facing_direction:
		Vector2i(0,1):sprite.set_region_rect(get_meta("EnemyRect_Down")as Rect2i)
		Vector2i(0,-1):sprite.set_region_rect(get_meta("EnemyRect_Up")as Rect2i)
		Vector2i(-1,0):sprite.set_region_rect(get_meta("EnemyRect_Left")as Rect2i)
		Vector2i(1,0):sprite.set_region_rect(get_meta("EnemyRect_Right")as Rect2i)

func auto_walk(delta:float = 0.01)->void:
	if abs(pre_frame_position.x-position.x)<smallest_per_frame_speed&&abs(pre_frame_position.y-position.y)<smallest_per_frame_speed:
		print(pre_frame_position.x-position.x,pre_frame_position.y-position.y)
		facing_direction = get_random_direction()
		velocity = facing_direction*speed*delta
	pre_frame_position = position
	move_and_slide()
	
func set_can_fire()->void:
	can_fire = true
	
func auto_fire()->void:
	# 创建子弹实例
	if can_fire:
		var bullet_instance:Bullet = res_bullet.instantiate() as Bullet
		bullet_instance.connect("bullet_queue_free",Callable(self,"set_can_fire"))
		bullet_instance.set_property(Bullet.BulletOwner.Enemy,position,facing_direction)
		can_fire = false
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
	

func apply_damage(damage:int):
	health-=damage
	emit_signal("applied_damage",damage)
	if health==0:
		killed()

func killed()->void:
	self.queue_free()
	emit_signal("enemy_killed")


func _on_spawn_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "SpawnEnemy":
		spawn_sprite.visible=false
		sprite.visible=true
		can_move = true
		can_fire = true
		timer.connect("timeout",Callable(self,"call_deferred_auto_fire"))
		timer.start()
		

func animation_play_walk(play_rect:Rect2)->void:
	sprite.set_region_rect(play_rect)
	animation_player.play("Enemy_Walk")

func get_random_direction()->Vector2i:
	var in_num = randi_range(1,4)
	match in_num:
		1:return get_meta("Direction_Up") as Vector2i
		2:return get_meta("Direction_Down") as Vector2i
		3:return get_meta("Direction_Left") as Vector2i
		4:return get_meta("Direction_Right") as Vector2i
	return Vector2i(0,1)


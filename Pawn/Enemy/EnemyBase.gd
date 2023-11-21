class_name EnemyBase
extends CharacterBody2D

var res_bullet = preload("res://Pawn/Bullet/bullet.tscn")


var health:int
var speed:int
var bullet:int
var facing_direction:Vector2i

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
	bullet_instance.connect("bullet_queue_free",Callable(self,"auto_fire"))
	res_bullet.set_property(Bullet.BulletOwner.Enemy,position,facing_direction)
	# 将子弹添加到场景中
	get_parent().add_child(bullet_instance)

	
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


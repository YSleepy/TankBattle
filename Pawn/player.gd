class_name Player

extends CharacterBody2D

signal changed_facing_direction
signal killed

var speed = 200  # 移动速度
var facing_direction = Vector2i(0,-1) #角色朝向
var bullet_scene = preload("res://Pawn/Bullet/bullet.tscn")

var cant_fire:bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spawn_animation: Sprite2D = $SpawnAimation
@onready var spawn_animation_player: AnimationPlayer = $SpawnAnimationPlayer
@onready var timer: Timer = $Timer



func _ready() -> void:
	spawn_animation_player.play("SpawnPlayer")
	connect("changed_facing_direction",Callable(self,"correction_position"))
	timer.connect("timeout",Callable(self,"_on_timer_timeout_stop_animation"))
	timer.start()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire"):
		fire()

# TODO 未优化输入

func correction_position()->void:
	pass

func update_facing_direction(in_direction:Vector2)->void:
	if in_direction!=facing_direction:
		facing_direction = in_direction
		emit_signal("changed_facing_direction")

func player_move():
	var horizontal_input = Input.get_action_strength("Walk_Right") - Input.get_action_strength("Walk_Left")
	var vertical_input = Input.get_action_strength("Walk_Down") - Input.get_action_strength("Walk_Up")
	if horizontal_input>0:
		vertical_input=0
		animation_player.play("Walk_Right")
		facing_direction =Vector2i(1,0)
	elif horizontal_input<0:
		vertical_input=0
		animation_player.play("Walk_Left")
		facing_direction = Vector2i(-1,0)
	var horizontal_velocity = horizontal_input * speed
	velocity.x = horizontal_velocity
	# 处理垂直移动
	if vertical_input>0:
		horizontal_input=0
		animation_player.play("Walk_Down")
		facing_direction= Vector2i(0,1)
	elif vertical_input<0:
		horizontal_input=0
		animation_player.play("Walk_Up")
		facing_direction=Vector2i(0,-1)
	var vertical_velocity = vertical_input * speed
	velocity.y = vertical_velocity
	move_and_slide()

func play_fire_sound(in_metadata_path:String)->void:
	var sound_player:AudioStreamPlayer = AudioStreamPlayer.new()
	get_parent().add_child(sound_player)
	sound_player.finished.connect(func():sound_player.queue_free())
	sound_player.set_stream(get_meta(in_metadata_path))
	sound_player.play()

func can_fire()->void :
	cant_fire = false

func fire()->void :
	# can instance bullet?
	if cant_fire:
		return
	# 创建子弹实例
	cant_fire = true
	play_fire_sound("FireSound")
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.connect("bullet_queue_free",Callable(self,"can_fire"))
	bullet_instance.set_property(Bullet.BulletOwner.Player1,position,facing_direction)
	# 将子弹添加到场景中
	get_parent().add_child(bullet_instance)
	
	
@warning_ignore("unused_parameter")
func _process(delta):
	player_move()


func _on_timer_timeout_stop_animation():
	spawn_animation_player.stop(true)
	spawn_animation.visible = false
	

func killed_player()->void:
	set_process(false)
	play_fire_sound("PlayerKilled")
	emit_signal("killed")
	queue_free()



class_name Player

extends CharacterBody2D

var speed = 200  # 移动速度
var facing_direction = Vector2(0,-1) #角色朝向
var bullet_scene = preload("res://Pawn/Bullet/bullet.tscn")


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire"):
		fire()


# TODO 未优化输入


func player_move():
	var horizontal_input = Input.get_action_strength("Walk_Right") - Input.get_action_strength("Walk_Left")
	var vertical_input = Input.get_action_strength("Walk_Down") - Input.get_action_strength("Walk_Up")
	if horizontal_input>0:
		vertical_input=0
		animation_player.play("Walk_Right")
		facing_direction =Vector2(1,0)
	elif horizontal_input<0:
		vertical_input=0
		animation_player.play("Walk_Left")
		facing_direction = Vector2(-1,0)
	var horizontal_velocity = horizontal_input * speed
	velocity.x = horizontal_velocity
	# 处理垂直移动
	if vertical_input>0:
		horizontal_input=0
		animation_player.play("Walk_Down")
		facing_direction= Vector2(0,1)
	elif vertical_input<0:
		horizontal_input=0
		animation_player.play("Walk_Up")
		facing_direction=Vector2(0,-1)
	var vertical_velocity = vertical_input * speed
	velocity.y = vertical_velocity
	move_and_slide()

func fire():
	# 创建子弹实例
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.set_property(position,facing_direction)
	# 将子弹添加到场景中
	get_parent().add_child(bullet_instance)
	
func _process(delta):
	player_move()

# 如果需要处理碰撞，你可以重写下面的方法
# func _on_Collision_body_entered(body):
#     # 处理碰撞逻辑

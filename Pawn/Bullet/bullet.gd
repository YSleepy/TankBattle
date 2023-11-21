class_name Bullet
extends Node2D

enum BulletOwner{
	Player1,
	Player2,
	Enemy
}

signal bullet_queue_free

var bullet_speed = 300
var bullet_dirction : Vector2 = Vector2.ZERO
var bullet_widght = 6
var animation_player: AnimationPlayer
var bullet_owner:BulletOwner 

func set_property(in_bullet_owner:BulletOwner,spawn_position:Vector2,direction:Vector2,speed:int = 300) -> void:
	position = spawn_position
	bullet_dirction = direction
	bullet_speed = speed
	bullet_owner=in_bullet_owner
	animation_player = get_node("AnimationPlayer")
	
#	print(spawn_position,direction,speed,animation_player)
	
	if direction==Vector2.UP:
		animation_player.play("Fire_Up")
	elif direction==Vector2.DOWN:
		animation_player.play("Fire_Down")
	elif direction==Vector2.LEFT:
		animation_player.play("Fire_Left")
	elif direction==Vector2.RIGHT:
		animation_player.play("Fire_Right")



func _process(delta) -> void:
	var current_position = position
	current_position.x +=bullet_dirction.x * bullet_speed * delta
	current_position.y +=bullet_dirction.y * bullet_speed * delta
	position = current_position

func modify_bullet_map_position(in_modify_position:Vector2i,in_dirction:Vector2,in_position:Vector2)->Dictionary:
	var result:Dictionary

	if in_dirction.x!=0:
		#Modify y
		
		var temp_y = in_position.y/16
		in_modify_position.y = int(temp_y)
		result["Value"] = in_modify_position
		result["Modify"] = "y"
		if temp_y - int(temp_y) >=0.0 and temp_y - int(temp_y) <=0.3:
			result["Carry"]=-1
		elif temp_y - int(temp_y)>=0.7 and temp_y - int(temp_y)<1.0:
			result["Carry"]=1
		else:
			result["Carry"]=0
	if in_dirction.y!=0:
		#Modify x
		print(in_position)
		var temp_x = in_position.x/16
		in_modify_position.x = int(temp_x)
		result["Value"] = in_modify_position
		result["Modify"] = "x"
		if temp_x - int(temp_x) >=0.0 and temp_x - int(temp_x) <=0.3:
			result["Carry"]=-1
		elif temp_x - int(temp_x)>=0.7 and temp_x - int(temp_x)<1.0:
			result["Carry"]=1
		else:
			result["Carry"]=0
	return result

func attack_Scenne_Border(body:Node2D)->void:
	if body.is_in_group("Border"):
		emit_signal("bullet_queue_free")
		self.queue_free()
		print("Destory")
	if body.is_in_group("World_Scenne"):
		#Get TileMap,Find Bullet Position In Map
		var temp_tile_map = body as World_TileMap
		var map_position = temp_tile_map.local_to_map(position)
		#Modify map_position according direction
		var modified_position:Dictionary = modify_bullet_map_position(map_position,bullet_dirction,position)
		
		if modified_position["Modify"]=="x":
			var is_destory1 = temp_tile_map.set_tile(0,modified_position["Value"],-1)
			if is_destory1:
				emit_signal("bullet_queue_free")
				self.queue_free()
			print(modified_position["Value"])
			if modified_position["Carry"]!=0:
				modified_position["Value"].x += modified_position["Carry"]
				var is_destory2 = temp_tile_map.set_tile(0,modified_position["Value"],-1)
				if is_destory2:
					emit_signal("bullet_queue_free")
					self.queue_free()
		if modified_position["Modify"]=="y":
			var is_destory1 = temp_tile_map.set_tile(0,modified_position["Value"],-1)
			if is_destory1:
				emit_signal("bullet_queue_free")
				self.queue_free()
			if modified_position["Carry"]!=0:
				modified_position["Value"].y += modified_position["Carry"]
				var is_destory2 = temp_tile_map.set_tile(0,modified_position["Value"],-1)
				if is_destory2:
					emit_signal("bullet_queue_free")
					self.queue_free()
		var tile_data = temp_tile_map.get_cell_tile_data(0,map_position)
		if tile_data == null:
			print("Null")
		print(position,"原",map_position,"改",modified_position["Value"],"Carry",modified_position["Carry"],tile_data)
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	attack_Scenne_Border(body)

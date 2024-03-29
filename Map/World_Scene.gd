class_name WorldScene
extends TileMap

'''
Windows Width Height
416,416
Map range
0,25
border range
-1,26
目前地图设计子弹是不会与Grass和Water发生碰撞的
TileCanDestroy Rule : enum TileCanDestroy
	
'''
signal target_attacked

enum Enum_TileCanDestroy{
	Rock,
	Brick,
	Iron,
	Grass,
	Water,
	Target
}

const Per_Width = 16

func _ready() -> void:
	pass
#	var tile_data = get_cell_tile_data(0,Vector2i(6,24))
#	var TileCanDestroy = tile_data.get_custom_data("TileCanDestroy")
#	print(TileCanDestroy)

func play_sound(in_bullet_owner: Bullet.BulletOwner,in_metadata_path:String)->void:
	if in_bullet_owner != Bullet.BulletOwner.Enemy:
		$AudioStreamPlayer.set_stream(get_meta(in_metadata_path))
		$AudioStreamPlayer.play()


func set_tile(in_bullet_owner: Bullet.BulletOwner,in_damage:int,layer: int, coords: Vector2i, source_id: int = -1) -> bool:
	# return can destory bullet
	var tile_data = get_cell_tile_data(layer,coords)
	if tile_data == null:
		return false
	var TileCanDestroy = tile_data.get_custom_data("TileCanDestroy")
	match TileCanDestroy:
		Enum_TileCanDestroy.Rock:
			# 石头需要两下
			var hardness = tile_data.get_custom_data("Hardness")as int
			hardness -= in_damage
			if hardness <= 0:
				play_sound(in_bullet_owner,"AttackRock2")
				self.set_cell(layer,coords,source_id)
				return true
			else:
				play_sound(in_bullet_owner,"AttackRock")
				tile_data.set_custom_data("Hardness",hardness)
				return true

		Enum_TileCanDestroy.Brick:
			# 砖头需要一下
			play_sound(in_bullet_owner,"AttackBrick")
			self.set_cell(layer,coords,source_id)
			return true
			
		Enum_TileCanDestroy.Iron:
			# 铁块
			if in_damage>=3:
				self.set_cell(layer,coords,source_id)
				play_sound(in_bullet_owner,"AttackIron2")
			play_sound(in_bullet_owner,"AttackIron")
			return true
			
		Enum_TileCanDestroy.Target:
			emit_signal("target_attacked",null)
			return true
			
#		Enum_TileCanDestroy.Grass:
#			# 从下面穿过去
#			pass
#		Enum_TileCanDestroy.Water:
#			# 从上面穿过去
#			pass

	return false

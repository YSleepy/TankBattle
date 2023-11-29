class_name SelectLevel

extends Control

var level_id:int=1

var level_id_position1:Vector2i = Vector2i(16,19)# 10^1 10 位
var level_id_position0:Vector2i = Vector2i(17,19)# 10^0 1 个位


func _ready() -> void:
	$ColorRect.visible = false


func _on_next_button_down() -> void:
	level_id+=1
	correct_level_id()

func _on_pre_button_down() -> void:
	level_id-=1
	correct_level_id()
	

func correct_level_id()->void:
	level_id%=MainManager.LevelTotalNum
	if level_id == 0:
		level_id = MainManager.LevelTotalNum
	updata_ui()
	

func get_tileset_number_coords(in_int:int)->Vector2i:
	match in_int:
		0:return Vector2i(0,63)
		1:return Vector2i(1,63)
		2:return Vector2i(2,63)
		3:return Vector2i(3,63)
		4:return Vector2i(4,63)
		5:return Vector2i(5,63)
		6:return Vector2i(6,63)
		7:return Vector2i(7,63)
		8:return Vector2i(8,63)
		9:return Vector2i(9,63)
	return Vector2i(0,63)

func updata_ui()->void:
	if level_id/10==0:
		# 十位当个位使用
		$Letter2.set_cell(0,level_id_position1,0,get_tileset_number_coords(level_id))
		$Letter2.set_cell(0,level_id_position0)
	else:
		#十位不空，都写
		$Letter2.set_cell(0,level_id_position1,0,get_tileset_number_coords(level_id/10))
		$Letter2.set_cell(0,level_id_position0,0,get_tileset_number_coords(level_id%10))
	$ScrollContainer.set_h_scroll((level_id-1)*420)
	if level_id>MainManager.MaxUnlockLevelId:
		$ColorRect.visible = true
	else:
		$ColorRect.visible = false


func _on_play_button_down() -> void:
	if level_id>MainManager.MaxUnlockLevelId:
		pass
	else:
		MainManager.LevelId = level_id
		get_tree().change_scene_to_packed(load(MainManager.LevelBasePath%level_id))
		

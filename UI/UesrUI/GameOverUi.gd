class_name GameOverUi

extends Control
# 4,5.5,5.6,5

var select_level = preload("res://UI/SelectLevel/SelectLevel.tscn")

var is_win:bool = false


func set_win(is_win:bool):
	if !is_win:
		$ColorRect/Letter.set_cell(0,Vector2i(4,5),0,Vector2i(3,62))
		$ColorRect/Letter.set_cell(0,Vector2i(5,5),0,Vector2i(8,62))
		$ColorRect/Letter.set_cell(0,Vector2i(6,5),0,Vector2i(4,62))
	else:
		is_win = true
		update_manager_data()

func update_manager_data()->void:
	if MainManager.LevelTotalNum>MainManager.MaxUnlockLevelId:
		MainManager.MaxUnlockLevelId+=1
	else:
		#TODO All Level Is unlock
		pass

func _on_back_button_down() -> void:
	# 优化的话，部分场景可以选择设置可见性而不是重新加载
	get_tree().change_scene_to_packed(select_level)


func _on_replay_button_down() -> void:
	get_tree().change_scene_to_packed(load(MainManager.LevelBasePath%MainManager.LevelId))


func _on_next_button_down() -> void:
	if MainManager.LevelId<MainManager.MaxUnlockLevelId:
		MainManager.LevelId+=1
		get_tree().change_scene_to_packed(load(MainManager.LevelBasePath%MainManager.LevelId))
	else:
		$AnimationPlayer.play("AnimLock")




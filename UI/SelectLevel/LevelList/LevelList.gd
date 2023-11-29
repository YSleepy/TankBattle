class_name LevelList

extends HBoxContainer

var level_list_path:String
var level_list:Array

func _ready() -> void:
	for i in range(1,MainManager.LevelTotalNum+1):
		level_list_path =  "res://Map/Level/LevelTexture/World%d.tres"%i
		
		var res_texture = load(level_list_path)	
		if res_texture == null:
			break
		level_list.push_back(res_texture)
		var texture_rect :TextureRect = TextureRect.new()
		texture_rect.set_texture(res_texture)
		add_child(texture_rect)
		

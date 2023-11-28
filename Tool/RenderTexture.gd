class_name RenderTexture

extends Node2D

var res_scene = preload("res://Map/Level/world1.tscn")
var viewport 
func _ready() -> void:
	viewport = SubViewport.new()
	add_child(viewport)
	$AnimationPlayer.play("EnterGameSequence")
	render_texture()
# Player


func _on_player_button_down() -> void:
	pass


func render_texture():
	viewport.size = Vector2(416, 416)  # 设置视口大小
	var scene = res_scene.instantiate()
	viewport.add_child(scene)
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	viewport.set_process(true)
	
	
func _process(delta: float) -> void:
	var image : ViewportTexture = viewport.get_texture()
	var dynamic_texture : ImageTexture
	dynamic_texture = ImageTexture.create_from_image(image.get_image())
	var i = ResourceSaver.save(dynamic_texture,"res://Map/Level/LevelTexture/World1.tres")
	print(i)

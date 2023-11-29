class_name RenderTexture

extends Node2D

var render_id:int=1
var next_render_id:int = 1
var render_total_num :int =2
var path:String


var viewport :SubViewport

func _ready() -> void:
	render_total_num = MainManager.LevelTotalNum
	
	viewport = SubViewport.new()
	viewport.size = Vector2(416, 416)  # 设置视口大小
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	
	add_child(viewport)
	$Timer.connect("timeout",Callable(self,"render_next"))
	$Timer.start()
# Player

func render_next():
	render_id+=1
	if render_id>render_total_num:
		get_tree().quit()

	
func _process(delta: float) -> void:
	if render_id == next_render_id:
		path= MainManager.LevelBasePath%render_id
		next_render_id+=1
	var res_scene = load(path)
	var scene = res_scene.instantiate()
	if viewport.get_child_count()>0:
		viewport.remove_child(viewport.get_child(0))
	viewport.add_child(scene)

	if render_id<=render_total_num:
		var image : ViewportTexture = viewport.get_texture()
		var dynamic_texture : ImageTexture
		dynamic_texture = ImageTexture.create_from_image(image.get_image())
		var i = ResourceSaver.save(dynamic_texture,MainManager.LevelTextureBasePath%render_id)
	print(render_id)



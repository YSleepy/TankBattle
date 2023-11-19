class_name World
extends TileMap

'''
Windows Width Height
416,416
Map range
0,25
border range
-1,26

'''

const Per_Width = 16

func _ready() -> void:
	var tile_set_id = tile_set.get_custom_data_layer_by_name("TileCanDestroy")
	print(tile_set_id)
	set_tile(0,Vector2i(2,24))
#	get_layer_for_body_rid()
#	 get_collider_rid()

func set_tile(layer: int, coords: Vector2i, source_id: int = -1):
	var tile_data = get_cell_tile_data(layer,coords)
	var TileCanDestroy = tile_data.get_custom_data("TileCanDestroy")
	print(TileCanDestroy)

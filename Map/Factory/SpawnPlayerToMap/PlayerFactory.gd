class_name PlayerFactory
extends Factory

signal player_total_num_change

var res_player = preload("res://Pawn/player.tscn")

var player_total_num:int

func _ready() -> void:
	player_total_num = get_meta("PlayTotalNum")as int
	make_player()


func make_player()->void:
	if player_total_num>0:
		await get_tree().create_timer(0.8).timeout
		var instance_player: Player = res_player.instantiate() as Player
		instance_player.connect("killed",Callable(self,"make_player"))
		instance_player.position = self.position
		get_parent().add_child.call_deferred(instance_player)
		player_total_num-=1
		emit_signal("player_total_num_change")
	else :
		emit_signal("factory_queue_free",FactoryType.PlayerFactory)
		self.queue_free()

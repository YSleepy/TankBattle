class_name World

extends Node2D

#48,16(208,16)(368,16)(160,400)
var enemy_factory_num:int

var is_win:bool=false


func _ready() -> void:
	enemy_factory_num = get_meta("EnemyFactoryNum")
	$EnemyFactory.connect("factory_queue_free",(Callable(self,"try_game_over")))
	$EnemyFactory1.connect("factory_queue_free",(Callable(self,"try_game_over")))
	$EnemyFactory2.connect("factory_queue_free",(Callable(self,"try_game_over")))
	$PlayerFactory.connect("factory_queue_free",(Callable(self,"try_game_over")))
	$PlayerFactory.connect("player_total_num_change",func():$PlayerHealthUi.update_health($PlayerFactory.player_total_num))
	$World_Scenne.connect("target_attacked",(Callable(self,"try_game_over")))


func try_game_over(in_factory_type):
	if in_factory_type == null:
		$GameOverUi.set_win(false)
		$AnimationPlayer.play("AnimGameOver")
		
		return
	if in_factory_type == Factory.FactoryType.EnemyFactory:
		enemy_factory_num-=1
		if enemy_factory_num <=0:
			$GameOverUi.set_win(true)
			$AnimationPlayer.play("AnimGameOver")
	elif in_factory_type == Factory.FactoryType.PlayerFactory:
		if $PlayerFactory.player_total_num <=0:
			$GameOverUi.set_win(false)
			$AnimationPlayer.play("AnimGameOver")

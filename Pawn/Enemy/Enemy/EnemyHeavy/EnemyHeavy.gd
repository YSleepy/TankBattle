class_name EnemyHeavy
extends EnemyBase

func _ready() -> void:
	super._ready()
	connect("applied_damage",Callable(self,""))


func on_applied_damage_change_Animation(damage:int):
	if damage>0&&health>0:
		match  health:
			2:
				set_meta("EnemyRect_Up",Rect2i(56,112,56,28))
				set_meta("EnemyRect_Down",Rect2i(56,168,56,28))
				set_meta("EnemyRect_Left",Rect2i(56,196,56,28))
				set_meta("EnemyRect_Right",Rect2i(56,140,56,28))
			1:
				set_meta("EnemyRect_Up",Rect2i(112,112,56,28))
				set_meta("EnemyRect_Down",Rect2i(112,168,56,28))
				set_meta("EnemyRect_Left",Rect2i(112,196,56,28))
				set_meta("EnemyRect_Right",Rect2i(112,140,56,28))

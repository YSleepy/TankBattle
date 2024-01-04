class_name GameSave

extends Node

static func save_game(manager:Manager):
	var file = FileAccess.open("user://SaveGame.data",FileAccess.WRITE)
	if file != null:
		print("Save Open File")
		file.store_var(manager.MaxUnlockLevelId)
		file.store_var(manager.LevelId)
		file.close()

static func load_game(manager:Manager):
	var file = FileAccess.open("user://SaveGame.data",FileAccess.READ)
	if file != null:
		print("Load Open File")
		manager.MaxUnlockLevelId = file.get_var()
		manager.LevelId = file.get_var()
		file.close()

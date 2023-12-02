class_name Manager

extends CanvasLayer


# 2340×1080
# *416


enum GameModeType{
	Null,
	Player,
	Players
}
# 以解锁的关卡最大id
var MaxUnlockLevelId:int = 2
# 当前游玩关卡id
var LevelId:int = 1
# 关卡总数
var LevelTotalNum:int = 10
# 游戏模式，单人，双人
var GameMode:GameModeType = GameModeType.Null
# 玩家工厂，玩家有几个坦克可用，就相当于生命值了


var LevelBasePath:String = "res://Map/Level/world%d.tscn"
var LevelTextureBasePath:String = "res://Map/Level/LevelTexture/World%d.tres"

var PlayerFactory1PlayerNum = 2
var PlayerFactory2PlayerNum = 2

func _ready() -> void:
	pass

func PlayerSound(in_SoundPath)->void:
	var SoundPlayer:AudioStreamPlayer = AudioStreamPlayer.new()
	SoundPlayer.finished.connect(func():SoundPlayer.queue_free())
	var audio = load(in_SoundPath)
	SoundPlayer.set_stream(audio)
	add_child(SoundPlayer)
	SoundPlayer.play()



func PlaySceneTransition()->void:
	$AnimationPlayer.play("Transition")

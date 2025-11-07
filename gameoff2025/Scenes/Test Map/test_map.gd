extends Node2D
class_name Test_Map

@export var player: Player

func _ready() -> void:
	Global.player = player

extends Node2D
class_name AbilityBase

var Player :Base = null
var AbilityName :String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_owner():
		Player=get_owner()

func _activate() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

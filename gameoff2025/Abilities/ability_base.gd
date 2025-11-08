extends Node2D
class_name AbilityBase

enum AbilityTypeEnum {
	ActiveAttack,
	PassiveAttack,
	PassiveAbility
}

@export var AbilityType :AbilityTypeEnum 

var Player :Base = null
var AbilityName :String = ""
@export var Cooldown :float

var _cooldown_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_owner():
		Player=get_owner()
		if AbilityType == AbilityTypeEnum.PassiveAbility:
			_activate()
		if AbilityType == AbilityTypeEnum.PassiveAttack:
			_cooldown_timer = Timer.new()
			_cooldown_timer.wait_time = Cooldown
			_cooldown_timer.autostart = true
			_cooldown_timer.one_shot = false
			add_child(_cooldown_timer)
			_cooldown_timer.timeout.connect(_on_cooldown)
			_cooldown_timer.start()
		
func _on_cooldown():
	_activate()

func _activate() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends AbilityBase

func _activate() -> void:
	Player.health_component.max_health=Player.health_component.max_health*1.3

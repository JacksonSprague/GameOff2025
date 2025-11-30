extends AbilityBase

func _activate() -> void:
	Player.health_component.max_health=Player.health_component.max_health*1.3
	Player.health_component.current_health=Player.health_component.current_health*1.3

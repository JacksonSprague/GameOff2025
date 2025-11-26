extends AbilityBase

func _activate() -> void:
	Player.BurrowChargeNeeded =Player.BurrowChargeNeeded*0.9
	

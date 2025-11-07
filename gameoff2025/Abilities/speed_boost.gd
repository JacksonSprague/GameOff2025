extends AbilityBase

func _activate() -> void:
	Player.stats.speed+=5000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends AbilityBase

func _activate() -> void:
	print("MAG_Grow")
	Player.MagRange=Player.MagRange*1.3

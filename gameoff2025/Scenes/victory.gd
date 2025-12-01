extends Node2D


func _on_start_pressed() -> void:
	if $Fire.playing==false:
		$Fire.play()

func _on_options_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_fire_finished() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

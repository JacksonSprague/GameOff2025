extends Base
class_name Player

var move_dir: Vector2

func _process(delta: float) -> void:
	move_dir = Input.get_vector("Left", "Right", "Up", "Down")
	
	var current_velocity := move_dir * stats.speed
	position += current_velocity * delta
	position.x = clamp(position.x, -1500, 1500)
	position.y = clamp(position.y, -865, 858)
	
	update_animations()

func update_animations() -> void:
	if move_dir.length() > 0:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")

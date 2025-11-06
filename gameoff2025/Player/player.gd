extends CharacterBody2D


var max_speed = 700
var acceleration = 2000
var deceleration = 3000
var turn_speed = 20
var direction : Vector2 = Vector2(0,0)

var cur_velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	direction = get_input_direction()
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
		$AnimatedSprite2D.play("Walking")
		$AnimatedSprite2D.flip_h=direction.x<0
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		$AnimatedSprite2D.play("Idle")
	#if velocity.length() > 0:
	#	rotation = lerp_angle(rotation, velocity.angle(), turn_speed * delta)

	move_and_slide()
	
func get_input_direction() -> Vector2:
	direction = Vector2.ZERO
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	return direction.normalized() if direction.length() > 0 else Vector2.ZERO

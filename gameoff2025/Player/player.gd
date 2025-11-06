extends CharacterBody2D


var MAX_SPEED = 600.0
var CUR_SPEED = 0
var ACCEL = 1500
var direction : Vector2 = Vector2(0,0)

func _physics_process(delta: float) -> void:
	direction = Vector2(Input.get_axis("Left","Right"), Input.get_axis("Up","Down"))
	if direction:
		CUR_SPEED=move_toward(CUR_SPEED,MAX_SPEED,ACCEL*delta)
	else:
		CUR_SPEED=0
	print(CUR_SPEED)
	velocity=direction*CUR_SPEED

	move_and_slide()

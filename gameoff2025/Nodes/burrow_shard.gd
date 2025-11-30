extends Node2D

@export var magnet_target: Node2D
@export var magnet_accel: float = 2000      # acceleration strength
@export var magnet_max_speed: float = 1500  # speed cap
var current_speed: float = 0

var MAG: bool = false

func _physics_process(delta):
	if MAG and magnet_target:
		
		# Increase speed (acceleration)
		current_speed = min(current_speed + magnet_accel * delta, magnet_max_speed)

		# Move toward the target
		global_position = global_position.move_toward(
			magnet_target.global_position,
			current_speed * delta
		)

		# Check distance
		if global_position.distance_to(magnet_target.global_position) < 50:
			magnet_target.add_burrow_charge()
			queue_free()

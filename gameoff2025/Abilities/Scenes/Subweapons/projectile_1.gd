extends Area2D
class_name Projectile1

var dir :Vector2 = Vector2(1,0)
var speed=3000
var damage = 0
var Coredamage= 10



func _process(delta: float) -> void:
	position+=dir*speed*delta

func impactfunc():
	$CPUParticles2D.emitting=true
	$Sprite2D.visible=false
	speed=0



func _on_cpu_particles_2d_finished() -> void:
	queue_free()

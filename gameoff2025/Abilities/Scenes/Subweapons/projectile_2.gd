extends Area2D
class_name Projectile2

var dir :Vector2 = Vector2(1,0)
var speed=2000
var damage = 0
var Coredamage= 6

func _ready() -> void:
	monitoring=true
	monitorable=true
#ProjectileHit(area)


func _physics_process(delta: float) -> void:
	position+=dir*speed*delta
	rotation=dir.angle()




func impactfunc():
	$CPUParticles2D.emitting=true
	#$HitboxComponent.queue_free()
	#$CollisionShape2D.queue_free()
	#$Sprite2D.visible=false
	speed=speed/1.5



func _on_cpu_particles_2d_finished() -> void:
	#queue_free()
	pass

		#$HealthComponent.take_damage(area.get_parent().damage)
		#area.get_parent().impactfunc()




func _on_destroy_timeout() -> void:
	queue_free()


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemy"):
		var health_ref = area.get_parent().get_node("HealthComponent")
		if health_ref:
			health_ref.take_damage(damage)
		impactfunc()

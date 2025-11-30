extends Node
class_name HealthComponent

signal on_unit_hit
signal on_unit_died
signal on_health_changed(current: float, max: float)

var max_health := 1.0
var current_health := 1.0

func setup(stats: BaseStats) -> void:
	max_health = stats.health
	current_health = stats.health
	on_health_changed.emit(current_health, max_health)

func take_damage(value: float) -> void:
	#print("damaged "+name+" of:"+get_parent().name+" for: ")
	if current_health <= 0:
		return

	current_health -= value

	current_health = max(current_health, 0)
	
	on_unit_hit.emit()
	on_health_changed.emit(current_health, max_health)
	if get_parent().is_in_group("Player"):
		Global.cam.shake(10, 0.2,30)
		var animationP :AnimationPlayer = get_parent().get_node("HURT")
		if animationP:
			animationP.play("Hurt")
	
	if get_parent().has_method("start_flash"):
		get_parent().start_flash()
	
	if current_health <= 0:
		current_health = 0
		on_unit_died.emit()
		call_deferred("die")


func heal(amount: float) -> void:
	if current_health <= 0:
		return
	
	current_health += amount
	current_health = min(current_health, max_health)
	on_health_changed.emit(current_health, max_health)

func die() -> void:
	if get_parent().is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	if get_parent().is_in_group("Enemy"):
		var hurtbox = get_parent().get_node("HurtboxComponent")
		var hitbox = get_parent().get_node("HitboxComponent")
		if hurtbox:
			hurtbox.queue_free()
		if hitbox:
			hitbox.queue_free()
		$"../VisualsDisappear".start()
		if $"../CPUParticles2D":
			$"../CPUParticles2D".emitting=true
		var spawned = $"..".ShardRef.instantiate()
		get_tree().current_scene.add_child(spawned)
	
		spawned.global_position=$"..".global_position
	

extends Area2D
class_name HitboxComponent

signal on_hit_hurtbox(hurtbox: HurtboxComponent)

@export var damage := 1.0
var critical := false
var knockback_power := 0.0
var source: Node2D

func enable () -> void:
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	
func disable() -> void:
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	
func setup(setdamage: float, setcritical: bool, setknockback: float, setsource: Node2D) -> void:
			self.damage = setdamage
			self.critical = setcritical
			knockback_power = setknockback
			self.source = setsource


func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		on_hit_hurtbox.emit(area)
		print(area.owner.name)

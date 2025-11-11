extends Node2D
class_name CharacterBase


@export var stats: BaseStats

@onready var visuals: Node2D = %Visuals
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent


func _ready() -> void:
	health_component.setup(stats)


func _on_hurtbox_component_on_damaged(hitbox: HitboxComponent) -> void:
	if health_component.current_health <= 0:
		return
	
	health_component.take_damage(hitbox.damage)
	print("%s: %d" % [name, health_component.current_health])

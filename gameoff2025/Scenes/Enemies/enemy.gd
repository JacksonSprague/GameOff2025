extends CharacterBase
class_name Enemy

const ShardRef = preload("res://Nodes/BurrowShard.tscn")
@export var flock_push := 20.0

@onready var vision_area: Area2D = $VisionArea

@onready var mat = $Visuals/AnimatedSprite2D.material.duplicate()


var flash_time :=0.1

var can_move := true
var move_dir: Vector2

func _ready():
	$Visuals/AnimatedSprite2D.material = mat
	health_component.setup(stats)


func _process(delta: float) -> void:
	if not can_move:
		return
	
	if not can_move_towards_player():
		return
	
	position += get_move_direction() * stats.speed * delta
	update_rotation()

func get_move_direction() -> Vector2:
	if not is_instance_valid(Global.player):
		return Vector2.ZERO
	
	var direction := global_position.direction_to(Global.player.global_position)
	for area: Node2D in vision_area.get_overlapping_areas():
		if area != self and area.is_inside_tree():
			var vector := global_position - area.global_position
			direction += flock_push * vector.normalized() / vector.length()
	
	return direction

func update_rotation() -> void:
	if not is_instance_valid(Global.player):
		return
	
	var player_pos := Global.player.global_position
	var moving_right := global_position.x < player_pos.x
	visuals.scale = Vector2(0.5, 0.5) if moving_right else Vector2(-0.5, 0.5)

func can_move_towards_player() -> bool:
	return is_instance_valid(Global.player) and\
	global_position.distance_to(Global.player.global_position) > 60  

func start_flash():
	mat.set("shader_param/flash_strength", 1.0)
	await get_tree().create_timer(flash_time).timeout
	mat.set("shader_param/flash_strength", 0.0)

func _on_area_entered(area: Area2D) -> void:
	ProjectileHit(area)


func ProjectileHit(area: Area2D):
	if area.name=="WaveCore":
		if $AnimationPlayer.has_animation("Wave"):
			$AnimationPlayer.play("Wave")
		var hurtbox = $HurtboxComponent
		var hitbox = $HitboxComponent
		if hurtbox:
			hurtbox.queue_free()
		if hitbox:
			hitbox.queue_free()



func _on_cpu_particles_2d_finished() -> void:
	queue_free()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()


func _on_visuals_disappear_timeout() -> void:
	if %Visuals:
		%Visuals.visible=false

extends AbilityBase
const ProjectileScene = preload("res://Abilities/Scenes/Subweapons/Projectile2.tscn")
var aimdir
var target
var projectielref

var hasrand=false
func _process(_delta: float) -> void:
	target = get_nearest_enemy()
	aimdir = get_direction_to_enemy()

func _activate() -> void:
	if (not get_direction_to_enemy()==Vector2.ZERO) and (get_parent().Burrowing==false):
		projectielref=null
		projectielref = ProjectileScene.instantiate()
		projectielref.damage=projectielref.Coredamage*get_parent().damagemultiplier
		get_tree().current_scene.add_child(projectielref)
		projectielref.global_position=global_position+(aimdir*10)+Vector2(randf_range(-50,50),randf_range(-100,10))
		projectielref.dir=aimdir

func get_nearest_enemy() -> Node:
	var nearest_enemy = null
	var nearest_distance = INF
	
	for Enemy in get_tree().get_nodes_in_group("Enemy"):
		if not is_instance_valid(Enemy):
			continue
		var dist = global_position.distance_to(Enemy.global_position)
		if dist < nearest_distance:
			nearest_distance=dist
			nearest_enemy=Enemy
	return nearest_enemy

func get_direction_to_enemy() -> Vector2:
	var enemyref = target
	if enemyref == null:
		return Vector2.ZERO
	var dir = (enemyref.global_position - global_position).normalized()
	return dir

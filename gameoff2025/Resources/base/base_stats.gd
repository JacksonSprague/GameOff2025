extends Resource
class_name BaseStats

enum BaseType {
	PLAYER,
	ENEMY
}

@export var name: String
@export var type: BaseType
@export var icon: Texture2D
@export var health := 1.0
@export var max_health := 1.0
@export var health_increased_per_wave := 1.0
@export var damage := 1.0
@export var damage_increased_per_wave := 1.0
@export var speed := 300
@export var luck := 1.0
@export var block_chance := 0.0
@export var shell_drop := 1.0

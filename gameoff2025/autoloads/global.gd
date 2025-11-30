extends Node

#signal on_create_block_text(base: Node2D)
#signal on_create_damage_text(base: Node2D, hitbox: HitboxComponent)

enum UpgradeTier{
	COMMON,
	RARE,
	EPIC,
	LEGENDARY
}

var player: Player

var cam: Camera2D

func get_chance_sucess(chance: float) -> bool:
	var random := randf_range(0, 1.0)
	if random < chance:
		return true
	return false


const FLOATING_TEXT = preload("uid://dwkw27p5oxnxy")

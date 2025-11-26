extends Node2D
class_name WeaponBehavior

@export var weapon: Weapon

var critical := false

func execute_attack() -> void:
	pass

func get_damage() -> void:
	var damage:= weapon.data.stats.damage + Global.player.stats.damage
	var crit_change := weapon.data.stats.crit_chance
##	if Global.get_chance_sucess(crit_chance):
##		critical = true
##		damage = ceil()

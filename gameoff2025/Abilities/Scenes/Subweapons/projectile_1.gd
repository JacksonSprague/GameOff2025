extends Area2D
class_name Projectile1

var dir :Vector2 = Vector2(1,0)
var speed=1000
var damage =10

func _process(delta: float) -> void:
	position+=dir*speed*delta


func _on_area_entered(area: Area2D) -> void:
	if area==Enemy:
		print("enemy")

extends Node2D
class_name BigWave
var go = false
var speed = 3000
var dir = 1
var StartPoint=0000
var INTERPFACTOR = 0
var OwnerRef :GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OwnerRef=get_parent()
	StartPoint=position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$CPUParticles2D2.global_position.x=OwnerRef.PlayerRef.position.x
	$CPUParticles2D.global_position.x=OwnerRef.PlayerRef.position.x
	$WaveCore/CPUParticles2D3.position.x=OwnerRef.PlayerRef.position.x
	position.y=4500*$INTERP.rotation_degrees




func _Crash():
	$WaveCore/AnimationPlayer.play("INTERP")


func Receed():
	$WaveCore/AnimationPlayer.play("Receed")

func callpowerups():
	OwnerRef.PowerUps()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="INTERP":
		#OwnerRef.PowerUps()
		pass
	if anim_name=="Receed":
		OwnerRef.AwaitNextWave()


func _on_wave_core_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		if area.has_method("ProjectileHit"):
			area.ProjectileHit($WaveCore)
	

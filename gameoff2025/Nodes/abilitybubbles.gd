extends Node2D
class_name AbilityBubble

var Highlighted = false
@export var AbilityName :String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/AnimatedSprite2D.play(AbilityName)
	modulate = Color(0.8, 0.8, 0.9, 0.9)
	$AnimationPlayer.speed_scale=randf_range(0.7,1.3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Click") and Highlighted:
		POP()




func _on_area_2d_mouse_entered() -> void:
	modulate = Color(1, 1, 1, 1)
	Highlighted=true
	$Highlight.play()

func _on_area_2d_mouse_exited() -> void:
	modulate = Color(0.8, 0.8, 0.9, 0.9)
	Highlighted=false
	$DeHighlight.play()

func POP():
	$POP.play()
	if get_parent().has_method("AbilitySelected"):
		get_parent().AbilitySelected(AbilityName)
	$Area2D.queue_free()


func _on_pop_finished() -> void:
	queue_free()

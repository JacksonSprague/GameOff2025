extends Node2D

var Highlighted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(0.8, 0.8, 0.9, 0.9)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	queue_free()

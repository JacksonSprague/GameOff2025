extends Node2D
class_name AbilityBubble

var Highlighted = false
@export var AbilityName :String
@export var AbilityDescription :String

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
	get_parent().PlayerRef.ui_ref.get_node("Root/MainDivider/MarginContainer/AbilityDescription/MarginContainer/VBoxContainer/AbilityName").text=AbilityName.split("_")[1]
	get_parent().PlayerRef.ui_ref.get_node("Root/MainDivider/MarginContainer/AbilityDescription/MarginContainer/VBoxContainer/Ability Description").text=AbilityDescription
	get_parent().PlayerRef.ui_ref.get_node("Root/MainDivider/MarginContainer/AbilityDescription").visible=true
	

func _on_area_2d_mouse_exited() -> void:
	modulate = Color(0.8, 0.8, 0.9, 0.9)
	Highlighted=false
	$DeHighlight.play()
	get_parent().PlayerRef.ui_ref.get_node("Root/MainDivider/MarginContainer/AbilityDescription").visible=false

func POP():
	$POP.play()
	get_parent().PlayerRef.ui_ref.get_node("Root/MainDivider/MarginContainer/AbilityDescription").visible=false
	if get_parent().has_method("AbilitySelected"):
		get_parent().AbilitySelected(AbilityName)
	$Area2D.queue_free()


func _on_pop_finished() -> void:
	queue_free()

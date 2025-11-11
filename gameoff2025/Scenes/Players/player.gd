extends CharacterBase
class_name Player

const UI = preload("res://Scenes/UI/HUD.tscn")
var ui_ref :Player_HUD


var move_dir: Vector2

func _ready() -> void:
	super._ready()
	ui_ref= UI.instantiate()
	add_child(ui_ref)
	##if ui_ref.get_node("Root/MainDivider/MarginContainer/AbilityDescription"):
		#ui_ref.get_node("Root/MainDivider/MarginContainer/AbilityDescription").visible=true


func _process(delta: float) -> void:
	move_dir = Input.get_vector("Left", "Right", "Up", "Down")
	
	var current_velocity := move_dir * stats.speed
	position += current_velocity * delta
	
	## Not sure why we need this
	#position.x = clamp(position.x, -1500, 1500)
	#position.y = clamp(position.y, -865, 858)
	
	
	update_animations()

func update_animations() -> void:
	if move_dir.length() > 0:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")

extends CharacterBase
class_name Player

const UI = preload("res://Scenes/UI/HUD.tscn")
var ui_ref :Player_HUD
@export var game_manager_ref :GameManager

var BurrowCharge :float = 0
var BurrowChargeNeeded :float =100

#placeholder values for now. Currently Start_X_Pos does nothing, that will come into play when we actually design the level
var Start_X_Pos = 150
var End_X_Pos = 50000

@onready var weapon_container: WeaponContainer = $Visuals/WeaponContainer


var current_weapons: Array[Weapon] = []

var move_dir: Vector2

var Burrowing = false
var canUnBurrow = false

func _ready() -> void:
	super._ready()
	ui_ref= UI.instantiate()
	add_child(ui_ref)
	
	add_weapon(preload("res://Resources/Items/Weapons/Melee/Pincher/item_pincher_1.tres"))

	
func _process(delta: float) -> void:
	move_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var current_velocity := move_dir * stats.speed
	
	if Burrowing == false:
		position += current_velocity * delta
	
	position.y = clamp(position.y, -2500, 2400)
	position.x = clamp(position.x,-146,2010201021)
	update_animations()
	"res://Resources/Items/Weapons/Melee/Pincher/item_pincher_1.tres"
	ui_ref.get_node("Root/MainDivider/HBoxContainer/MarginContainer/HBoxContainer/BurrowBar").value=(BurrowCharge / BurrowChargeNeeded)*100
	ui_ref.get_node("Root/MainDivider/TopSection/MarginContainer/HBoxContainer/ProgressBar").value=(position.x / End_X_Pos)*100
	ui_ref.get_node("Root/MainDivider/HBoxContainer/MarginContainer/HBoxContainer/HealthBar").value=($HealthComponent.current_health / $HealthComponent.max_health)*100
	
	#placeholder until we get enemies, you will earn this by killing them
	if not Burrowing:
		BurrowCharge+=1
	
	
	if Input.is_action_just_pressed("Burrow") and BurrowCharge >= BurrowChargeNeeded and not Burrowing:
		Burrow()
	if Input.is_action_just_pressed("Burrow") and canUnBurrow:
		if game_manager_ref.isWave==false:
			UnBurrow()

func add_weapon(data: ItemWeapon) -> void:
	var weapon := data.scene.instantiate() as Weapon
	add_child(weapon)
	
	weapon.setup_weapon(data)
	current_weapons.append(weapon)
	weapon_container.update_weapons_position(current_weapons)

func update_animations() -> void:
	if move_dir.length() > 0 and not Burrowing:
		animated_sprite_2d.play("walk")
	elif not Burrowing:
		animated_sprite_2d.play("idle")

func Burrow():
	BurrowCharge=0
	animated_sprite_2d.play("burrow")
	Burrowing=true
	
func UnBurrow():
	BurrowCharge=0
	animated_sprite_2d.play("unburrow")

func is_facing_right() -> bool:
	return visuals.scale.x == -0.5

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation=="unburrow":
		Burrowing=false
		canUnBurrow=false
	if animated_sprite_2d.animation=="burrow":
		canUnBurrow=true

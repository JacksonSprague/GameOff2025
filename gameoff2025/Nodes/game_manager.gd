extends Node2D
class_name GameManager

@export var PlayerRef :Player

var Difficulty = 1
const WaveScene = preload("res://Nodes/BIG_wave.tscn")
const BubbleScene = preload("res://Nodes/Abilitybubbles.tscn")
var BigWaveRef :BigWave

var Bubble1Ref :AbilityBubble
var Bubble2Ref :AbilityBubble
var Bubble3Ref :AbilityBubble

##Abilities must be added here for them to appear. And ability name MUST match the name of the node
## it goes "name": then the weight (how common it is), then reference the node itself. Higher numbers are more common, lower are more rare.
var ability_dictionary = {
	"a_Attack": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Attack.tscn")},
	"a_Health": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Health.tscn")},
	"a_Speed": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Speed.tscn")},
	"a_Stamina": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Stamina.tscn")},
	"a_Weapon": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Weapon.tscn")}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Ability Spawn Core/AnimationPlayer".play("Fall")
	$Wave_Frequency.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Warning.position.x=PlayerRef.position.x
	$Warning.position.y=PlayerRef.position.y+200
	$"Ability Spawn Core".global_position.x=PlayerRef.global_position.x
	$"Ability Spawn Core".global_position.y=PlayerRef.global_position.y+(1500*$"Ability Spawn Core/Interper".rotation_degrees)
	
	if Bubble1Ref:
		Bubble1Ref.position=$"Ability Spawn Core/Bubble 1".global_position
		
	if Bubble2Ref:
		Bubble2Ref.position=$"Ability Spawn Core/Bubble 2".global_position
		
	if Bubble3Ref:
		Bubble3Ref.position=$"Ability Spawn Core/Bubble 3".global_position


func PowerUps():
	$"Ability Spawn Core/AnimationPlayer".play("Rise")
	Bubble1Ref = BubbleScene.instantiate()
	Bubble1Ref.AbilityName=weighted_dictionary_pick(ability_dictionary)
	add_child(Bubble1Ref)
	print(Bubble1Ref.AbilityName)
	
	Bubble2Ref = BubbleScene.instantiate()
	Bubble2Ref.AbilityName=weighted_dictionary_pick(ability_dictionary)
	add_child(Bubble2Ref)
	print(Bubble2Ref.AbilityName)
	
	Bubble3Ref = BubbleScene.instantiate()
	Bubble3Ref.AbilityName=weighted_dictionary_pick(ability_dictionary)
	add_child(Bubble3Ref)
	print(Bubble3Ref.AbilityName)
	Bubble1Ref.get_node("Area2D/CollisionShape2D").disabled=true
	Bubble2Ref.get_node("Area2D/CollisionShape2D").disabled=true
	Bubble3Ref.get_node("Area2D/CollisionShape2D").disabled=true


func AbilitySelected(AbilityName :String):
	var NewAbilityNode
	$"Ability Spawn Core/AnimationPlayer".play("Fall")
	Bubble1Ref.get_node("Area2D/CollisionShape2D").disabled=true
	Bubble2Ref.get_node("Area2D/CollisionShape2D").disabled=true
	Bubble3Ref.get_node("Area2D/CollisionShape2D").disabled=true
	BigWaveRef.Receed()
	if ability_dictionary.has(AbilityName):
		var abilitydata = ability_dictionary[AbilityName]
		NewAbilityNode = abilitydata["scene"].instantiate()
		PlayerRef.add_child(NewAbilityNode)
		print(PlayerRef.get_children())

	

func AwaitNextWave():
	print("waiting")
	BigWaveRef.queue_free()
	$Wave_Frequency.start()

func _on_wave_frequency_timeout() -> void:
	$Warning.visible=true
	$Countdown_timer.start()

func _on_countdown_timer_timeout() -> void:
	$Warning.visible=false
	BigWaveRef = WaveScene.instantiate()
	add_child(BigWaveRef)
	BigWaveRef.global_position.x=PlayerRef.position.x
	BigWaveRef.global_position.y=3500
	BigWaveRef._Crash()
	print("CRASSSH")

func weighted_dictionary_pick(dict : Dictionary) -> String:
	var total_weight :float=0.0
	for key in dict.keys():
		var w = dict[key]
		if typeof(w) == TYPE_DICTIONARY and w.has("weight"):
			total_weight+=float(w["weight"])
		else:
			total_weight+=float(w)
	if total_weight <= 0:
		return "Nothing to Pick"
	
	var r = randf()*total_weight
	
	var acc = 0.0
	for key in dict.keys():
		var w = dict[key]
		if typeof(w) == TYPE_DICTIONARY and w.has("weight"):
			acc += float(w["weight"])
		else:
			acc += float(w)
			
		if r <= acc:
			return key
	
	return dict.keys()[-1]


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="Fall":
		if Bubble1Ref : Bubble1Ref.queue_free()
		if Bubble2Ref : Bubble2Ref.queue_free()
		if Bubble3Ref : Bubble3Ref.queue_free()
	if anim_name=="Rise":
		Bubble1Ref.get_node("Area2D/CollisionShape2D").disabled=false
		Bubble2Ref.get_node("Area2D/CollisionShape2D").disabled=false
		Bubble3Ref.get_node("Area2D/CollisionShape2D").disabled=false
	

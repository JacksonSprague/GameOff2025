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
## it goes "name": then the weight (how common it is). Higher numbers are more common, lower are more rare.
var ability_dictionary = {
	"a_Attack": 1,
	"a_Health": 1,
	"a_Speed": 1,
	"a_Stamina": 1,
	"a_Weapon": 1.
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Wave_Frequency.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Warning.position.x=PlayerRef.position.x
	$Warning.position.y=PlayerRef.position.y+200
	


func PowerUps():
	print("Power!")
	$"Ability Spawn Core".position=PlayerRef.position
	
	
	Bubble1Ref = BubbleScene.instantiate()
	add_child(Bubble1Ref)
	Bubble1Ref.position=$"Ability Spawn Core/Bubble 1".position
	
	Bubble2Ref = BubbleScene.instantiate()
	add_child(Bubble2Ref)
	Bubble2Ref.position=$"Ability Spawn Core/Bubble 2".position
	
	Bubble3Ref = BubbleScene.instantiate()
	add_child(Bubble3Ref)
	Bubble3Ref.position=$"Ability Spawn Core/Bubble 3".position
	
	#BigWaveRef.Receed()

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

#func weighted_dictionary_pick(dict : Dictionary) -> String:
	var total_weight :float=0.0
	for key in dict.keys():
		var w = dict[key]
		of typeof(w) == TYPE_D
	




	
	
	

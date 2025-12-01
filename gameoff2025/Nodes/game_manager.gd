extends Node2D
class_name GameManager

@export var PlayerRef :Player
@export var enemy_ref1 :PackedScene
var Wavecount=0
var Difficulty = 1
const WaveScene = preload("res://Nodes/BIG_wave.tscn")
const BubbleScene = preload("res://Nodes/Abilitybubbles.tscn")
var BigWaveRef :BigWave

var Bubble1Ref :AbilityBubble
var Bubble2Ref :AbilityBubble
var Bubble3Ref :AbilityBubble

var isWave =false 

var enemy_dictionary = {
	"SandMite1": {"weight" : 1.5, "scene" : preload("res://Scenes/Enemies/sand_mite.tscn")},
	"SandMite2": {"weight" : 0, "scene" : preload("res://Scenes/Enemies/sand_mite_epic.tscn")},
	"SandMite3": {"weight" : 0, "scene" : preload("res://Scenes/Enemies/sand_mite_legendary.tscn")},
	"SandDollar1": {"weight" : 0, "scene" : preload("res://Scenes/Enemies/sand_dollar.tscn")},
	"SandDollar2": {"weight" : 0, "scene" : preload("res://Scenes/Enemies/sand_dollar_epic.tscn")},
}


##Abilities must be added here for them to appear. And ability name MUST match the name of the node
## it goes "name": then the weight (how common it is), then reference the node itself. Higher numbers are more common, lower are more rare.
var ability_dictionary = {
	"a_Attack": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Attack.tscn"), "desc" : "Increase attack power by 10%"},
	"a_Health": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Health.tscn"), "desc" : "Increase defense by 30%"},
	"a_Speed": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Speed.tscn"), "desc" : "Roam the beach 10% faster"},
	"a_Shell Strength": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Shell Strength.tscn"), "desc" : "Reduce shell strength needed to burrow by 10%"},
	"a_Small Shot": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Small Shot.tscn"), "desc" : "Gain or enhance the SMALL SHOT weapon which fires small but deadly projectiles"},
	"a_Magnet": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Magnet.tscn"), "desc" : "Increase the distance from which you can grab shell shards by 30%"},
	"a_Big Shot": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Big Shot.tscn"), "desc" : "Gain or enhance the BIG SHOT, a slow but powerful projectile that pierces through enemies"},
	"a_Rapid Shot": {"weight" : 1, "scene" : preload("res://Abilities/Scenes/a_Rapid Shot.tscn"), "desc" : "Gain or enhance the RAPID SHOT, an attack that peppers your enemies with rapid damage"}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Ability Spawn Core/AnimationPlayer".play("Fall")
	$Wave_Frequency.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Warning.position.x=PlayerRef.position.x
	$Warning.position.y=PlayerRef.position.y+200
	$"Ability Spawn Core".global_position.x=PlayerRef.global_position.x
	$"Ability Spawn Core".global_position.y=PlayerRef.global_position.y+100+(1600*$"Ability Spawn Core/Interper".rotation_degrees)
	
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
	Bubble1Ref.AbilityDescription=ability_dictionary[Bubble1Ref.AbilityName]["desc"]
	add_child(Bubble1Ref)
	
	Bubble2Ref = BubbleScene.instantiate()
	Bubble2Ref.AbilityName=weighted_dictionary_pick(ability_dictionary)
	Bubble2Ref.AbilityDescription=ability_dictionary[Bubble2Ref.AbilityName]["desc"]
	add_child(Bubble2Ref)
	
	Bubble3Ref = BubbleScene.instantiate()
	Bubble3Ref.AbilityName=weighted_dictionary_pick(ability_dictionary)
	Bubble3Ref.AbilityDescription=ability_dictionary[Bubble3Ref.AbilityName]["desc"]
	add_child(Bubble3Ref)
	Bubble1Ref.get_node("BubblesArea/CollisionShape2D").disabled=true
	Bubble2Ref.get_node("BubblesArea/CollisionShape2D").disabled=true
	Bubble3Ref.get_node("BubblesArea/CollisionShape2D").disabled=true


func AbilitySelected(AbilityName :String):
	var NewAbilityNode
	$MusicFade.play("Wave_End")
	$"Ability Spawn Core/AnimationPlayer".play("Fall")
	Bubble1Ref.get_node("BubblesArea/CollisionShape2D").disabled=true
	Bubble2Ref.get_node("BubblesArea/CollisionShape2D").disabled=true
	Bubble3Ref.get_node("BubblesArea/CollisionShape2D").disabled=true
	BigWaveRef.Receed()
	$WAVECrash.play()
	if ability_dictionary.has(AbilityName):
		var abilitydata = ability_dictionary[AbilityName]
		NewAbilityNode = abilitydata["scene"].instantiate()
		PlayerRef.add_child(NewAbilityNode) 
		#NewAbilityNode._activate()
	

func AwaitNextWave():
	BigWaveRef.queue_free()
	$Spawn_Timer.wait_time=$Spawn_Timer.wait_time/1.1
	$Spawn_Timer.start()
	$Wave_Frequency.wait_time=clamp($Wave_Frequency.wait_time/1.05,6,100)
	$Wave_Frequency.start()
	Wavecount+=1
	
	if Wavecount>2:
		enemy_dictionary["SandDollar1"]["weight"]=2
	if Wavecount>4:
		enemy_dictionary["SandMite2"]["weight"]=2
	if Wavecount>6:
		enemy_dictionary["SandDollar2"]["weight"]=3
	if Wavecount>8:
		enemy_dictionary["SandMite3"]["weight"]=3

func _on_wave_frequency_timeout() -> void:
	$Warning.visible=true
	$Countdown_timer.start()
	$Alarm.play()

func _on_countdown_timer_timeout() -> void:
	$Warning.visible=false
	isWave=true
	$Spawn_Timer.stop()
	BigWaveRef = WaveScene.instantiate()
	add_child(BigWaveRef)
	BigWaveRef.global_position.x=PlayerRef.position.x
	BigWaveRef.global_position.y=3500
	BigWaveRef._Crash()
	Global.cam.shake(20,3.5,1)
	$MusicFade.play("Wave")
	$WAVECrash.play()

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
		isWave=false
	if anim_name=="Rise":
		Bubble1Ref.get_node("BubblesArea/CollisionShape2D").disabled=false
		Bubble2Ref.get_node("BubblesArea/CollisionShape2D").disabled=false
		Bubble3Ref.get_node("BubblesArea/CollisionShape2D").disabled=false



func _on_spawn_timer_timeout() -> void:
	var enemy = enemy_dictionary[weighted_dictionary_pick(enemy_dictionary)]["scene"].instantiate()
	add_child(enemy)
	var radius = 2000
	enemy.position = point_on_oval(PlayerRef.global_position,radius*1.2,radius,randf_range(0,360))
	
func point_on_oval(center: Vector2, radius_x: float, radius_y: float, angle: float) -> Vector2:
	var x = center.x + radius_x * cos(angle)
	var y = center.y + radius_y * sin(angle)
	return Vector2(x, y)
	
func enemy_weighted_dictionary_pick(dict : Dictionary) -> String:
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
	
	
	
	

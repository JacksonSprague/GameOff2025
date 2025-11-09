extends Node2D
class_name GameManager

@export var PlayerRef :Player

var Difficulty = 1
const WaveScene = preload("res://Nodes/BIG_wave.tscn")
var BigWaveRef :BigWave

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Wave_Frequency.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Warning.position.x=PlayerRef.position.x
	$Warning.position.y=PlayerRef.position.y+200
	


func PowerUps():
	print("Power!")
	BigWaveRef.Receed()

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

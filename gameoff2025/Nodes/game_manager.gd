extends Node2D
@export var PlayerRef :Player

var Difficulty = 1
const WaveScene = preload("res://Nodes/BIG_wave.tscn")
var BigWaveRef :BigWave

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Wave_Frequency.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_wave_frequency_timeout() -> void:
	BigWaveRef = WaveScene.instantiate()
	add_child(BigWaveRef)
	BigWaveRef.global_position.x=PlayerRef.global_position.x
	BigWaveRef.global_position.y=PlayerRef.global_position.y-2500
	BigWaveRef._Crash()
	print("CRASSSH")

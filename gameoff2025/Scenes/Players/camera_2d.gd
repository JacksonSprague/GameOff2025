extends Camera2D

var shake_amount: float = 20.0
var shake_duration: float = 0.2
var shake_speed: float = 40.0     # ← NEW VARIABLE (how fast the shake wiggles)
var shaking: bool = false

var _original_offset := Vector2.ZERO
var _time := 0.0


func shake(amount: float = shake_amount, duration: float = shake_duration, speed: float = shake_speed):
	if shaking:
		return

	shaking = true
	_time = 0.0

	shake_amount = amount
	shake_duration = duration
	shake_speed = speed

	_original_offset = offset


func _process(delta):
	if not shaking:
		return

	_time += delta

	if _time >= shake_duration:
		# stop shake
		offset = _original_offset
		shaking = false
		return

	# slow or fast wiggle based on shake_speed
	var wiggle = sin(_time * shake_speed)

	offset = _original_offset + Vector2(
		wiggle * randf_range(-shake_amount, shake_amount),
		wiggle * randf_range(-shake_amount, shake_amount)
	)
	
func _ready():
	Global.cam = self

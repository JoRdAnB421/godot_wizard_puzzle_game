extends TextureButton

@export var cooldown = 1.0

func _ready() -> void:
	PlayerState.cast_spell_signal.connect(_on_spell_used)
	
	$Timer.wait_time = cooldown
	#$Sweep.texture_progress = texture_normal
	$Sweep.value = 0
	set_process(false)
	
func _process(_delta: float) -> void:
	$Sweep.value = int(($Timer.time_left/cooldown) * 100)
	
func _on_spell_used():
	disabled = true
	set_process(true)
	$Timer.start()
	
func _on_Timer_timeout():
	print("spells ready")
	$Sweep.value = 0
	disabled = false
	set_process(true)

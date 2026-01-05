extends CharacterBody2D

# get the grvaity from the scene
@onready var gravity_val = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var gravity_vec : Vector2

func _ready() -> void:
	var scene = get_tree().current_scene
	if scene and scene.has_meta("gravity_vec"):
		gravity_vec = scene.get_meta("gravity_vec")
	else:
		push_warning("gravity vec not found, using default")
		gravity_vec = Vector2.DOWN

func _physics_process(delta: float) -> void:
	var scene = get_tree().current_scene
	if scene and scene.has_meta("gravity_vec"):
		gravity_vec = scene.get_meta("gravity_vec")
	velocity += gravity_val*gravity_vec*delta
	
	move_and_slide()

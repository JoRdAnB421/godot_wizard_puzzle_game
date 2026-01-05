extends CharacterBody2D

# get the grvaity from the scene
@onready var gravity_val = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var gravity_vec = get_tree().get_current_scene().get_meta("gravity_vec")

func _physics_process(delta: float) -> void:
	gravity_vec = get_parent().get_parent().get_meta("gravity_vec")
	velocity += gravity_val*gravity_vec*delta
	
	move_and_slide()

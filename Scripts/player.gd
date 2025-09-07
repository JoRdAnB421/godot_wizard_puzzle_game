extends CharacterBody2D

@export var speed = 10
@export var jump_speed = -40

# get the grvaity from the scene
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add gravity
	velocity.y += gravity*delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		
	# Get input direction
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction*speed

	move_and_slide()

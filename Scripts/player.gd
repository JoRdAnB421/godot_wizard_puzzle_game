extends CharacterBody2D

@export var speed = 10
@export var jump_speed = -40

# get the gravity from the project Settings
@onready var gravity_val = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var gravity_vec = 	get_parent().get_meta("gravity_vec")

func _physics_process(delta: float) -> void:
	"""Process the physics simulations"""
	# Get current gravity direction
	gravity_vec = 	get_parent().get_meta("gravity_vec")
	var right_vec = gravity_vec.orthogonal()
	
	# Add gravity acceleration
	velocity += gravity_vec*gravity_val*delta
	
	# Basic movement and jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity += gravity_vec*jump_speed
		
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity = velocity.slide(right_vec) + right_vec*direction*speed
	else:
		velocity = velocity.slide(right_vec)
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("cast_spell"):
		PlayerState.cast_spell(1)
		
		


	

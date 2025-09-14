extends CharacterBody2D

@export var speed = 10
@export var jump_speed = -40

@onready var main_scene: Node2D = $".."
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var box: CharacterBody2D = $"../Box"

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
		rotate_room()


func rotate_room() -> void:
	"""Rotate the Wizard and then set reset gravity"""
	rotation += PI/2 # Rotates the player sprite
	
	# Rotation for the gravity veector always pi/2
	var rot_matrix = [Vector2(0,-1), 
					  Vector2(1,0)
					 ]
	var new_gravity_vec = Vector2(gravity_vec.dot(rot_matrix[0]),
							  	  gravity_vec.dot(rot_matrix[1])
								 ).round()
	get_parent().set_meta("gravity_vec", new_gravity_vec)
	up_direction = -new_gravity_vec

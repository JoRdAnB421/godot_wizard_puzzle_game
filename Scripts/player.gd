extends Area2D

@export var speed = 400
var screen_size # size of game window 


func _ready() -> void:
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		print("moving right")
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if Input.is_action_just_pressed("jump"):
		position.y-=5

	if velocity.length()>0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

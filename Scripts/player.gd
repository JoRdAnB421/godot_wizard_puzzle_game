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
	var gravity_vec = 	get_parent().get_meta("gravity_vec")
	# Add gravity
	velocity += gravity_vec*gravity_val*delta
	#print(gravity_vec)e
	
	# Basic movement and jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	#var direction = Input.get_axis("move_left", "move_right")
	#velocity.x = direction*speed

	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("cast_spell"):
		new_rotation()


func new_rotation() -> void:
	"""Rotate the Wizard and then set reset gravity"""
	rotation += PI/2
	print(rotation)
	var rot_matrix = [Vector2(cos(rotation),-sin(rotation)), 
					  Vector2(sin(rotation),cos(rotation))
					 ]
	var new_gravity_vec = Vector2(gravity_vec.dot(rot_matrix[0]),
							  	  gravity_vec.dot(rot_matrix[1])
								 )
	get_parent().set_meta("gravity_vec", new_gravity_vec)

func rotate_room_about_wizard(clockwise: bool = true) -> void:
	var wizards_cell = tile_map_layer.local_to_map(
		tile_map_layer.to_local(position)
	)
	
	# Grabs the cells foor all edges
	var used_cells = tile_map_layer.get_used_cells()
	if used_cells.is_empty():
		return
		
	# Store old tiles
	var old_tiles = []
	for cell in used_cells:
		var source_id = tile_map_layer.get_cell_source_id(cell)
		var atlas_coords = tile_map_layer.get_cell_atlas_coords(cell)
		old_tiles.append({
				"cell": cell, 
				"source_id": source_id,
				"atlas": atlas_coords})
	
	tile_map_layer.clear()
	
	# set new tiles
	for tile in old_tiles:
		var old_cell = tile["cell"]
		var rel = old_cell - wizards_cell
		var rotated = Vector2i(rel.y, -rel.x) # 90 degrees
		var new_cell = wizards_cell + rotated
		tile_map_layer.set_cell(new_cell, tile["source_id"], tile["atlas"])
	
	
	# rotate objects inside the room
	var rel_pos = box.position - position
	var rot = Vector2(rel_pos.y, -rel_pos.x)
	var new_pos = box.position + rot
	
	box.position = new_pos

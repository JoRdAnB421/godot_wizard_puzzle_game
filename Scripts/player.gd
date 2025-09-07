extends CharacterBody2D

@export var speed = 10
@export var jump_speed = -40

@onready var main_scene: Node2D = $".."
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"


# get the grvaity from the scene
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add gravity
	velocity.y += gravity*delta

	# Basic movement and jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction*speed

	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("cast_spell"):
		rotate_room_about_wizard()


func rotate_room_about_wizard(clockwise: bool = true) -> void:
	var wizards_cell = tile_map_layer.local_to_map(
		tile_map_layer.to_local(position)
	)
	
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
		
	for tile in old_tiles:
		var old_cell = tile["cell"]
		var rel = old_cell - wizards_cell
		var rotated = Vector2i(rel.y, -rel.x) # 90 degrees
		var new_cell = wizards_cell + rotated
		tile_map_layer.set_cell(new_cell, tile["source_id"], tile["atlas"])
	

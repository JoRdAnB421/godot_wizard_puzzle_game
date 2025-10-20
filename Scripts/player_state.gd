extends Node

@onready var known_spells: Array[SpellOption] = []

func _ready() -> void:
	add_spell("rotate_clockwise", 1, Rect2(10.0, 22.5, 77.0, 79.0))
	add_spell("rotate_anticlockwise", 2, Rect2(85.0, 22.5, 84.0,84.0))

func _get_known_spells() -> Array[SpellOption]:
	"""Returns a list of currently known spells with atlas texture"""
	return known_spells

func add_spell(spell_name:String, spell_id:int, region:Rect2) -> void:
	"""Adds a new spell to the UI and into the player state memory"""
	var new_spell = SpellOption.new()
	new_spell.name = spell_name
	new_spell.id = spell_id
	new_spell.region = region
	
	known_spells.append(new_spell)
	

## Below we store the functions for the spells

func cast_spell(spell_id: int) -> void:
	match spell_id:
		1: rotate_room(-1) # Anti-clockwise
		2: rotate_room(1)  # Clockwise

func rotate_room(direction: float) -> void:
	"""Attempt to have room rotate smoothly whilst freezing the player in 
	place
	"""
	var main_scene = Global.current_scene.get_child(-1)
	var goal_angle = main_scene.rotation + PI/2 * direction
	var tween = main_scene.create_tween()
	tween.tween_property(main_scene, "rotation", 
						 goal_angle, 0.75)

extends Area2D

@export var spell_name: String
@export var spell_id: int
@export var spell_region: Vector2

func _ready() -> void:
	connect("body_entered", _add_spell)

func _add_spell(_sig) -> void:
	"""Adds new spell to wheel"""
	#var fire_spell = SpellOption.new()
	#fire_spell.name = "Fireball!"
	#fire_spell.atlas = load("res://Art/spell_symbols.png")
	#fire_spell.region = Rect2(180.0, 0.0, 76.0, 122.5)
	#PlayerState.known_spells.append(fire_spell)
	PlayerState.add_spell("Fireball!", 3, Rect2(180.0, 0.0, 76.0, 122.5))
	queue_free()
	

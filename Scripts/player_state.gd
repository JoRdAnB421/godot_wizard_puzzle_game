extends Node

@onready var known_spells: Array[SpellOption] = [SpellOption.new()]

func _ready() -> void:
	var rotate_room_spell = SpellOption.new()
	rotate_room_spell.name = "Rotate_room"
	rotate_room_spell.atlas = load("res://Art/spell_symbols.png")
	rotate_room_spell.region = Rect2(0.0, 30.0, 70.0, 70.0)
	
	known_spells.append(rotate_room_spell)

func _get_known_spells() -> Array[SpellOption]:
	"""Returns a list of currently known spells with atlas texture"""
	return known_spells

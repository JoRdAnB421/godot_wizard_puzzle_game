extends Area2D


func _ready() -> void:
	connect("body_entered", add_spell)

func add_spell(_sig) -> void:
	"""Adds new spell to wheel"""
	var fire_spell = SpellOption.new()
	fire_spell.name = "Fireball!"
	fire_spell.atlas = load("res://Art/spell_symbols.png")
	fire_spell.region = Rect2(180.0, 0.0, 76.0, 122.5)
	
	PlayerState.known_spells.append(fire_spell)
	
	print("GOT FIREBALL!!")

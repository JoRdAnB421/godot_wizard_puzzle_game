class_name SpellOption extends AtlasTexture

@export var name = ""
@export var id : int = 999

func _init() -> void:
	self.atlas = load("res://Art/spell_symbols.png")

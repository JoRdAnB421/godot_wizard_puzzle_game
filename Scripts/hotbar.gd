extends VBoxContainer

@onready var options: Array[SpellOption]
@onready var slots = preload("res://Scenes/slot.tscn")

func _ready() -> void:
	# Gets the currently known spells
	options = PlayerState._get_known_spells()	
	for spell in options:
		# Initialise the hotbar with known spells
		var new_spell_slot = slots.instantiate()
		var icon = new_spell_slot
		
		# Make a unique texture so each item doesn't share a sprite
		var new_texture := AtlasTexture.new()
		new_texture.atlas = icon.texture_normal.atlas
		new_texture.region = spell.region
		icon.texture_normal = new_texture
		
		new_spell_slot.get_child(-1).get_child(0).text = str(spell.id)
		add_child(new_spell_slot)
	
	PlayerState.connect("num_spells_changed", pickup_spell)
	
func pickup_spell() -> void:
	# Initialise the hotbar with known spells
	var spell = PlayerState._get_known_spells()[-1]
	var new_spell_slot = slots.instantiate()
	var icon = new_spell_slot
	
	# Make a unique texture so each item doesn't share a sprite
	var new_texture := AtlasTexture.new()
	new_texture.atlas = icon.texture_normal.atlas
	new_texture.region = spell.region
	icon.texture_normal = new_texture
	
	new_spell_slot.get_child(-1).get_child(0).text = str(spell.id)
	add_child(new_spell_slot)
	
